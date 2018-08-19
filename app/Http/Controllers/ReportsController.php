<?php
	
	namespace App\Http\Controllers;
	
	use App\Bill;
	use App\Subscription;
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
			} else if ($request->input('filter') == 'subscriptions') {
				if ($user->isAdmin() || $user->isOperations()) {
					$data = Subscription::with(['optionItem'])->get();
				} else {
					$data = Subscription::whereIn('user_id',
						Auth::user()->getClient()->users->pluck('id'))
						->where('status', 'AT_DEPARTMENT_HEAD')
						->orWhere('status', 'AT_PURCHASING_HEAD')
						->with(['optionItem'])
						->get();
				}
			} else {
				return $this->arrayResponse([]);
			}
			
			return $this->collectionResponse($data);
		}
	}
