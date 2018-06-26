<?php
	
	namespace App\Http\Controllers;
	
	use App\Appointment;
	use App\Delivery;
	use App\Order;
	use App\ServiceRequest;
	use App\Subscription;
	use App\User;
	use Auth;
	use Carbon\Carbon;
	use Illuminate\Database\Eloquent\Builder;
	
	class UIController extends Controller
	{
		//
		/**
		 * @throws \App\Exceptions\WrappedException
		 */
		public function drawerItems()
		{
			/** @var User $user */
			$user = User::with('role')->findOrFail(Auth::user()->id);
			
			if($user->isSupplier()){
				$items = [
					['icon' => 'dashboard', 'title' => 'Dashboard', 'route' => 'dashboard', 'pendingApprovals' => 0],
					['icon' => 'shopping_cart', 'title' => 'Ordered Products', 'route' => 'orderItems', 'pendingApprovals' => 0],
					['icon' => 'work', 'title' => 'LPOs', 'route' => 'lpos', 'pendingApprovals' => 0],
				];
			} else if ($user->isAdmin() || $user->isOperations()) {
				$items = [
					['icon' => 'dashboard', 'title' => 'Dashboard', 'route' => 'dashboard', 'pendingApprovals' => 0],
					['icon' => 'work', 'title' => 'Clients', 'route' => 'clients', 'pendingApprovals' => 0],
					['icon' => 'attach_money', 'title' => 'Top Ups', 'route' => 'topUps', 'pendingApprovals' => 0],
					['icon' => 'group', 'title' => 'Users', 'route' => 'users', 'pendingApprovals' => 0],
					['icon' => 'build', 'title' => 'Roles', 'route' => 'roles', 'pendingApprovals' => 0],
					['icon' => 'shop', 'title' => 'All Products', 'route' => 'products', 'pendingApprovals' => 0],
					['icon' => 'view_list', 'title' => 'Product Categories', 'route' => 'categories', 'pendingApprovals' => 0],
					['icon' => 'local_shipping', 'title' => 'Deliveries', 'route' => 'deliveries', 'pendingApprovals' => 0],
					['icon' => 'shopping_cart', 'title' => 'Ordered Products', 'route' => 'orderItems', 'pendingApprovals' => 0],
					['icon' => 'shopping_basket', 'title' => 'Orders', 'route' => 'orders', 'pendingApprovals' => 0],
					['icon' => 'work', 'title' => 'LPOs', 'route' => 'lpos', 'pendingApprovals' => 0],
				];
			} else {
				$client = Auth::user()->getClient();
				$pendingOrders = Order::whereIn('user_id', $client->users->pluck('id'))
					->whereHas('items', function (Builder $builder) {
						$builder->where('status', '!=', 'DELIVERED')
							->where('status', '!=', 'REJECTED');
					})
					->count();
				$pendingDeliveries = Delivery::whereIn('user_id', $client->users->pluck('id'))
					->whereHas('items', function (Builder $builder) {
						$builder->where('status', '!=', 'REJECTED')
							->where('status', '!=', 'AT_DESTINATION');
					})->count();
				
				$pendingSubscriptions = Subscription::whereIn('user_id', $client->users->pluck('id'))
					->where('status', '!=', 'REJECTED')
					->Where('status', '!=', 'EXPIRED')
					->Where('status', '!=', 'ACTIVE')
					->count();
				
				$pendingITServiceRequests = ServiceRequest::whereIn('user_id', $client->users->pluck('id'))
					->where('status', '!=', 'ATTENDED')
					->where('status', '!=', 'REJECTED')
					->whereType('IT')->count();
				
				$pendingRepairServiceRequests = ServiceRequest::whereIn('user_id', $client->users->pluck('id'))
					->where('status', '!=', 'ATTENDED')
					->where('status', '!=', 'REJECTED')
					->whereType('REPAIR')->count();
				
				$appointmentsToday = Appointment::whereIn('user_id', $client->users->pluck('id'))
					->whereDate('starting_at', Carbon::now()->toDateString())->count();
				
				if ($user->isClientAdmin()) {
					$items = [
						['icon' => 'dashboard', 'title' => 'Dashboard', 'route' => 'dashboard', 'pendingApprovals' => 0],
						['icon' => 'schedule', 'title' => 'Subscriptions', 'route' => 'subscriptions', 'pendingApprovals' => $pendingSubscriptions],
						['icon' => 'date_range', 'title' => 'Appointments', 'route' => 'appointments', 'pendingApprovals' => $appointmentsToday],
						//['icon' => 'shopping_cart', 'title' => 'Shopping', 'route' => 'shopping', 'pendingApprovals' => 0],
						//['icon' => 'shopping_basket', 'title' => 'Orders', 'route' => 'orders', 'pendingApprovals' => $pendingShopOrders],
						//['icon' => 'computer', 'title' => 'IT Services', 'route' => 'it', 'pendingApprovals' => $pendingITServiceRequests],
						//['icon' => 'build', 'title' => 'Repair Services', 'route' => 'repairs', 'pendingApprovals' => $pendingRepairServiceRequests],
						//['icon' => 'local_shipping', 'title' => 'Courier', 'route' => 'courier', 'pendingApprovals' => $pendingDeliveries],
						['icon' => 'group', 'title' => 'Users', 'route' => 'users', 'pendingApprovals' => 0],
						['icon' => 'group_work', 'title' => 'Departments', 'route' => 'departments', 'pendingApprovals' => 0],
						['icon' => 'person', 'title' => 'My Profile', 'route' => 'profile', 'pendingApprovals' => 0],
					];
				} else {
					$items = [
						['icon' => 'dashboard', 'title' => 'Dashboard', 'route' => 'dashboard', 'pendingApprovals' => 0],
						['icon' => 'schedule', 'title' => 'Subscriptions', 'route' => 'subscriptions', 'pendingApprovals' => $pendingSubscriptions],
						['icon' => 'date_range', 'title' => 'Appointments', 'route' => 'appointments', 'pendingApprovals' => $appointmentsToday],
						['icon' => 'shopping_cart', 'title' => 'Shopping', 'route' => 'shopping', 'pendingApprovals' => 0],
						['icon' => 'shopping_basket', 'title' => 'Orders', 'route' => 'orders', 'pendingApprovals' => $pendingOrders],
						//['icon' => 'computer', 'title' => 'IT Services', 'route' => 'it', 'pendingApprovals' => $pendingITServiceRequests],
						//['icon' => 'build', 'title' => 'Repair Services', 'route' => 'repairs', 'pendingApprovals' => $pendingRepairServiceRequests],
						['icon' => 'local_shipping', 'title' => 'Courier', 'route' => 'courier', 'pendingApprovals' => $pendingDeliveries],
						//['icon' => 'group', 'title' => 'Users', 'route' => 'users', 'pendingApprovals' => 0],
						//['icon' => 'group_work', 'title' => 'Departments', 'route' => 'departments', 'pendingApprovals' => 0],
						['icon' => 'person', 'title' => 'My Profile', 'route' => 'profile', 'pendingApprovals' => 0],
					];
				}
			}
			
			
			return $this->arrayResponse($items);
			
		}
		
		/**
		 * @return \Illuminate\Http\Response
		 * @throws \App\Exceptions\WrappedException
		 */
		public function balance()
		{
			$client = Auth::user()->getClient();
			
			$data = [
				'actual'  => $client->getBalance(),
				'limit'   => $client->limit,
				'spent'   => $client->getSpent(),
				'blocked' => $client->getBlocked(),
			];
			
			return $this->arrayResponse($data);
			
		}
		
	}
