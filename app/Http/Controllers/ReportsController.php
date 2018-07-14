<?php
	
	namespace App\Http\Controllers;
	
	use App\Bill;
	use Auth;
	use Illuminate\Http\Request;
	
	class ReportsController extends Controller
	{
		//
		
		/**
		 * @param \Illuminate\Http\Request $request
		 * @return \Illuminate\Http\Response
		 * @throws \App\Exceptions\WrappedException
		 */
		public function index(Request $request)
		{
			$this->validate($request, [
				'filter' => 'required|in:bills,subscriptions,shopping,courier',
			]);
			
			$user = Auth::user();
			
			if ($request->input('filter') == 'bills') {
				$data = ($user->isAdmin() || $user->isOperations()) ? Bill::all() : $user->getClient()->bills()->get();
			} else {
				return $this->arrayResponse([]);
			}
			
			return $this->collectionResponse($data);
		}
	}
