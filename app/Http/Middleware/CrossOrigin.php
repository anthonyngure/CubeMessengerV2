<?php
	
	namespace App\Http\Middleware;
	
	use Closure;
	
	class CrossOrigin
	{
		/**
		 * Handle an incoming request.
		 *
		 * @param  \Illuminate\Http\Request $request
		 * @param  \Closure                 $next
		 * @return mixed
		 */
		public function handle($request, Closure $next)
		{
			/** @var \Illuminate\Http\Response $response */
			$response = $next($request);
			
			$request->header('Origin');
			
			$response->header('Allowed-Origin', $request->header('Origin'));
			
			return $response;
		}
	}
