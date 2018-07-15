<?php
	
	namespace App\Http\Controllers;
	
	use App\CrudHeader;
	use App\LocalPurchaseOrder;
	use App\LocalPurchaseOrderItem;
	use App\Order;
	use App\OrderItem;
	use App\Rules\CommaSeparatedIds;
	use Auth;
	use Illuminate\Contracts\Filesystem\FileNotFoundException;
	use Illuminate\Http\Request;
	use Response;
	use Storage;
	
	class LocalPurchaseOrderController extends Controller
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
				'filter' => 'in:pending,received',
			]);
			
			$headers = CrudHeader::whereModel(LocalPurchaseOrder::class)->get();
			
			$user = Auth::user();
			
			if ($user->isAdmin() || $user->isOperations()) {
				$lpos = LocalPurchaseOrder::with(['supplier', 'items.orderItem.product', 'deliveryNoteReceivedBy']);
			} else {
				$lpos = $user->localPurchaseOrders()->with(['supplier', 'items.orderItem.product', 'deliveryNoteReceivedBy']);
			}
			
			if ($request->input('filter') == 'received') {
				$lpos = $lpos->whereNotNull('delivery_note_path');
			} else {
				$lpos = $lpos->whereNull('delivery_note_path');
			}
			
			return $this->collectionResponse($lpos->withCount('items')->get(), ['headers' => $headers]);
			
		}
		
		/**
		 * Show the form for creating a new resource.
		 *
		 * @return \Illuminate\Http\Response
		 */
		public function create()
		{
			//
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
		 * Show the form for editing the specified resource.
		 *
		 * @param  int $id
		 * @return \Illuminate\Http\Response
		 */
		public function edit($id)
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
		
		
		public function deliveryDocuments(Request $request, $id)
		{
			$this->validate($request, [
				'deliveryNoteFile' => 'required|mimes:pdf|max:10000',
				'invoiceFile'      => 'required|mimes:pdf|max:10000',
				'items'            => ['required', new CommaSeparatedIds(LocalPurchaseOrderItem::class)],
			]);
			
			
			/** @var \App\LocalPurchaseOrder $lpo */
			$lpo = LocalPurchaseOrder::findOrFail($id);
			
			//Update all selected lpo items to received=true
			$lpoItems = $lpo->items()->whereIn('id', explode(',', $request->input('items')))
				->get();
			/** @var \App\LocalPurchaseOrderItem $lpoItem */
			foreach ($lpoItems as $lpoItem) {
				$lpoItem->received = true;
				$lpoItem->save();
				$lpoItem->orderItem()->update([
					'status' => OrderItem::STATUS_RECEIVED_FROM_SUPPLIER,
				]);
				/** @var \App\OrderItem $orderItem */
				$orderItem = $lpoItem->orderItem()->firstOrFail();
				$orderItem->order()->update([
					'status' => Order::STATUS_PENDING_DISPATCH,
				]);
			}
			
			//Update all unselected items to not received
			$lpoItems = $lpo->items()->whereNotIn('id', explode(',', $request->input('items')))
				->get();
			/** @var \App\LocalPurchaseOrderItem $lpoItem */
			foreach ($lpoItems as $lpoItem) {
				$lpoItem->received = false;
				$lpoItem->save();
				$lpoItem->orderItem()->update([
					'status' => OrderItem::STATUS_NOT_RECEIVED_FROM_SUPPLIER,
				]);
				/** @var \App\OrderItem $orderItem */
				$orderItem = $lpoItem->orderItem()->firstOrFail();
				$orderItem->order()->update([
					'status' => Order::STATUS_PENDING_DISPATCH,
				]);
			}
			
			$deliveryNotePath = Storage::disk('public')->putFile('delivery_notes', $request->file('deliveryNoteFile'));
			$invoicePath = Storage::disk('public')->putFile('invoices', $request->file('invoiceFile'));
			
			$lpo->delivery_note_received_by_id = Auth::user()->id;
			$lpo->delivery_note_received_at = now()->toDateTimeString();
			$lpo->delivery_note_path = $deliveryNotePath;
			$lpo->invoice_pdf_path = $invoicePath;
			$lpo->save();
			
			return $this->index($request);
		}
		
	}
