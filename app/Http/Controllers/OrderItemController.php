<?php
	
	namespace App\Http\Controllers;
	
	use App\CrudHeader;
	use App\LocalPurchaseOrder;
	use App\LocalPurchaseOrderItem;
	use App\Notifications\LPONotification;
	use App\OrderItem;
	use App\Rules\CommaSeparatedIds;
	use Auth;
	use Illuminate\Http\Request;
	
	class OrderItemController extends Controller
	{
		/**
		 * Display a listing of the resource.
		 *
		 * @param \Illuminate\Http\Request $request
		 * @return \Illuminate\Http\Response
		 */
		public function index(Request $request)
		{
			$this->validate($request, [
				'filter' => 'required|in:PENDING_LPO,ACCEPTED_BY_SUPPLIER,REJECTED_BY_SUPPLIER',
			]);
			
			
			$user = Auth::user();
			
			$headers = CrudHeader::whereModel(OrderItem::class)->get();
			
			if ($user->isSupplier()) {
				$productsSupplied = $user->products()->get();
				$data = OrderItem::with('product.supplier')
					->whereIn('product_id', $productsSupplied->pluck('id'))
					->where('status', $request->input('filter'))
					->get();
			} else {
				$data = OrderItem::with('product.supplier')
					->where('status', $request->input('filter'))
					->get();
			}
			
			return $this->collectionResponse($data, ['headers' => $headers]);
			
		}
		
		
		/**
		 * Store a newly created resource in storage.
		 *
		 * @param  \Illuminate\Http\Request $request
		 * @return \Illuminate\Http\Response
		 */
		public function store(Request $request)
		{
			//
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
		 */
		public function update(Request $request, $id)
		{
			//
		}
		
		/**
		 * Remove the specified resource from storage.
		 *
		 * @param  int $id
		 * @return \Illuminate\Http\Response
		 */
		public function destroy($id)
		{
			//
		}
		
		/**
		 * @param \Illuminate\Http\Request $request
		 * @return \Illuminate\Http\Response
		 */
		public function generateLPO(Request $request)
		{
			$user = Auth::user();
			$productsSupplied = $user->products()->get();
			
			$this->validate($request, [
				'items' => ['required', new CommaSeparatedIds(OrderItem::class)],
			]);
			
			$lpo = LocalPurchaseOrder::create([
				'supplier_id' => $user->id,
			]);
			
			//Update all selected order items pending lpo to accepted by supplier
			$orderItems = OrderItem::whereIn('id', explode(',', $request->input('items')))
				->whereIn('product_id', $productsSupplied->pluck('id'))
				->where('status', OrderItem::STATUS_PENDING_LPO)
				->get();
			/** @var \App\OrderItem $orderItem */
			foreach ($orderItems as $orderItem) {
				$orderItem->status = OrderItem::STATUS_ACCEPTED_BY_SUPPLIER;
				$orderItem->save();
				$lpo->items()->save(new LocalPurchaseOrderItem([
					'order_item_id' => $orderItem->id,
				]));
			}
			
			//Update all unselected items to rejected by supplier
			$orderItems = OrderItem::whereNotIn('id', explode(',', $request->input('items')))
				->whereIn('product_id', $productsSupplied->pluck('id'))
				->where('status', OrderItem::STATUS_PENDING_LPO)
				->get();
			
			/** @var \App\OrderItem $orderItem */
			foreach ($orderItems as $orderItem) {
				$orderItem->status = OrderItem::STATUS_REJECTED_BY_SUPPLIER;
				$orderItem->save();
			}
			
			
			
			//Send notification
			$user->notify(new LPONotification($lpo, $user));
			
			$data = OrderItem::with('product.supplier')
				->whereIn('product_id', $productsSupplied->pluck('id'))
				->whereStatus(OrderItem::STATUS_PENDING_LPO)
				->get();
			
			return $this->collectionResponse($data);
			
		}
	}
