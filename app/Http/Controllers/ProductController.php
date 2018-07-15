<?php
	
	namespace App\Http\Controllers;
	
	use App\CrudHeader;
	use App\Product;
	use App\Traits\Paginates;
	use Illuminate\Http\Request;
	use Illuminate\Validation\Rule;
	
	class ProductController extends Controller
	{
		
		use Paginates;
		
		/**
		 * Display a listing of the resource.
		 *
		 * @param \Illuminate\Http\Request $request
		 * @return \Illuminate\Http\Response
		 * @throws \App\Exceptions\WrappedException
		 */
		public function index(Request $request)
		{
			
			$headers = CrudHeader::whereModel(Product::class)->get();
			
			$products = Product::with(['supplier', 'category'])->get();
			
			return $this->collectionResponse($products, ['headers' => $headers]);
		}
		
		
		/**
		 * Store a newly created resource in storage.
		 *
		 * @param  \Illuminate\Http\Request $request
		 * @return \Illuminate\Http\Response
		 */
		public function store(Request $request)
		{
			$this->validate($request, [
				'name'          => 'required|unique:products',
				'supplierId'    => 'required|numeric|exists:users,id',
				'categoryId'    => 'required|numeric|exists:categories,id',
				'price'         => 'required|numeric',
				'supplierPrice' => 'required|numeric',
			]);
			$product = Product::create([
				'name'           => $request->input('name'),
				'supplier_id'    => $request->input('supplierId'),
				'category_id'    => $request->input('categoryId'),
				'price'          => $request->input('price'),
				'supplier_price' => $request->input('supplierPrice'),
			]);
			
			return $this->show($product->id);
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
			$product = Product::with(['supplier', 'category'])->findOrFail($id);
			
			return $this->itemResponse($product);
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
			/** @var \App\Product $product */
			$product = Product::findOrFail($id);
			$this->validate($request, [
				'name'          => ['required', Rule::unique('products', 'name')->ignore($id)],
				'supplierId'    => 'numeric|exists:users,id',
				'categoryId'    => 'numeric|exists:categories,id',
				'price'         => 'required|numeric',
				'supplierPrice' => 'required|numeric',
			]);
			
			$product->name = $request->input('name');
			$product->supplier_id = empty($request->input('supplierId')) ? $product->supplier_id : $request->input('supplierId');
			$product->category_id = empty($request->input('categoryId')) ? $product->category_id : $request->input('categoryId');
			$product->price = $request->input('price');
			$product->supplier_price = $request->input('supplierPrice');
			
			$product->save();
			
			return $this->show($product->id);
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
	}