<?php
	
	namespace App\Http\Controllers;
	
	use App\Bill;
	use App\CrudHeader;
	use App\Exceptions\WrappedException;
	use App\Notifications\OrderDispatchedNotification;
	use App\Notifications\OrderNotification;
	use App\Order;
	use App\OrderItem;
	use App\Product;
	use App\Utils;
	use Auth;
	use Illuminate\Http\Request;
	use Validator;
	
	class OrderController extends Controller
	{
		
		/**
		 * Display a listing of the resource.
		 *
		 * @param \Illuminate\Http\Request $request
		 * @return \Illuminate\Http\Response
		 * @throws \App\Exceptions\WrappedException
		 */
		public function index(Request $request)
		{
			$this->validate($request, [
				'filter' => 'required|in:AT_DEPARTMENT_HEAD,AT_PURCHASING_HEAD,DELIVERED,REJECTED,DISPATCHED,APPROVED,PENDING_DISPATCH',
			]);
			
			$headers = CrudHeader::whereModel(Order::class)->orderBy('priority')->get();
			
			if (Auth::user()->isAdmin() || Auth::user()->isOperations()) {
				$orders = Order::with('items.product');
			} else {
				/** @var \App\Client $client */
				$client = Auth::user()->getClient();
				$orders = Order::whereIn('user_id', $client->users->pluck('id'));
				
			}
			
			$data = $orders->with(['items.product', 'rejectedBy.role', 'dispatchRider', 'dispatchedBy'])
				->where('status', $request->input('filter'))
				->withCount(Order::COUNTS)->get();
			
			return $this->collectionResponse($data, ['headers' => $headers]);
			
		}
		
		/**
		 * Store a newly created resource in storage.
		 *
		 * @param  \Illuminate\Http\Request $request
		 * @return \Illuminate\Http\Response
		 * @throws \App\Exceptions\WrappedException
		 * @throws \Illuminate\Validation\ValidationException
		 */
		public function store(Request $request)
		{
			/** @var \App\User $user */
			$user = Auth::user();
			
			/** @var \App\Client $client */
			$client = $user->getClient();
			
			$submittedOrderItems = $request->json()->all();
			
			if (empty($submittedOrderItems)) {
				throw new WrappedException("Order items cannot be empty!");
			}
			
			$orderItems = array();
			foreach ($submittedOrderItems as $submittedOrderItem) {
				Validator::validate($submittedOrderItem, [
					'productId' => 'required|numeric|exists:products,id',
					'quantity'  => 'required|numeric',
				]);
				
				/** @var Product $product */
				$product = Product::findOrFail($submittedOrderItem['productId']);
				array_push($orderItems, new OrderItem([
					'product_id'        => $submittedOrderItem['productId'],
					'quantity'          => $submittedOrderItem['quantity'],
					'price_at_purchase' => $product->price,
				]));
			}
			
			$totalCost = collect($orderItems)->sum(function (OrderItem $item) {
				return ($item->price_at_purchase * $item->quantity);
			});
			
			$insufficientBalanceMessage = 'You have insufficient balance to make an order for '
				. Utils::toCurrencyText($totalCost);
			
			$this->checkBalance($totalCost, $insufficientBalanceMessage);
			
			
			/** @var \App\Order $order */
			$order = $user->orders()->create([]);
			$order->items()->saveMany($orderItems);
			
			
			/** @var \App\Order $order */
			$order = Order::with('items.product')->findOrFail($order->id);
			
			$description = 'Purchase of ' . $order->items->count() . ' products';
			
			Bill::updateOrCreate([
				'client_id'     => $client->id,
				'billable_id'   => $order->id,
				'billable_type' => Order::class,
			], [
				'description' => $description,
				'amount'      => $order->items->sum(function (OrderItem $item) {
					return ($item->price_at_purchase * $item->quantity);
				}),
			]);
			
			$client->notify(new OrderNotification($order));
			
			return $this->itemCreatedResponse($order);
		}
		
		/**
		 * Display the specified resource.
		 *
		 * @param  int $id
		 * @return \Illuminate\Http\Response
		 */
		public function show($id)
		{
			//
		}
		
		
		/**
		 * Update the specified resource in storage.
		 *
		 * @param  \Illuminate\Http\Request $request
		 * @param  int                      $id
		 * @return \Illuminate\Http\Response
		 * @throws \App\Exceptions\WrappedException
		 * @throws \Exception
		 */
		public function update(Request $request, $id)
		{
			
			$this->validate($request, [
				'action' => 'required|in:approve,reject',
			]);
			
			
			/** @var \App\Order $order */
			$order = Order::with('items.product')->findOrFail($id);
			
			$this->handleApprovals($request, $order, 'APPROVED', function (Order $order) {
				if ($order->status == 'APPROVED') {
					$order->items()->update(['status' => 'PENDING_LPO']);
				}
			});
			
			//Reload the order after the necessary updates
			$data = Order::with('items.product')->findOrFail($id);
			
			return $this->itemUpdatedResponse($data);
			
		}
		
		/**
		 * Remove the specified resource from storage.
		 *
		 * @param  int $id
		 * @return \Illuminate\Http\Response
		 * @throws \Exception
		 */
		public function destroy($id)
		{
			/** @var Order $order */
			$order = Order::findOrFail($id);
			$order->bill()->delete();
			$order->items()->delete();
			$order->delete();
			
			return $this->itemDeletedResponse($order);
		}
		
		/**
		 * @param \Illuminate\Http\Request $request
		 * @param                          $id
		 * @return \Illuminate\Http\Response
		 * @throws \App\Exceptions\WrappedException
		 */
		public function dispatchToClient(Request $request, $id)
		{
			/** @var \App\Order $order */
			$order = Order::with('user.client')->findOrFail($id);
			$order->dispatched_at = now()->toDateTimeString();
			$order->dispatched_by_id = Auth::user()->id;
			$order->dispatch_rider_id = Utils::availableRider()->id;
			$order->status = Order::STATUS_DISPATCHED;
			$order->save();
			$order->user->client->notify(new OrderDispatchedNotification($order));
			
			$data = $request->all();
			$data['filter'] = Order::STATUS_PENDING_DISPATCH;
			$request->replace($data);
			
			return $this->index($request);
		}
	}
