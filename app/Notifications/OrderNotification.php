<?php
	
	namespace App\Notifications;
	
	use App\Order;
	use App\OrderItem;
	use Illuminate\Bus\Queueable;
	use Illuminate\Contracts\Queue\ShouldQueue;
	use Illuminate\Notifications\Messages\MailMessage;
	use Illuminate\Notifications\Notification;
	
	class OrderNotification extends Notification implements ShouldQueue
	{
		use Queueable;
		/**
		 * @var \App\Order
		 */
		private $order;
		
		/**
		 * Create a new notification instance.
		 *
		 * @param \App\Order $order
		 */
		public function __construct(Order $order)
		{
			//
			$this->order = $order;
		}
		
		/**
		 * Get the notification's delivery channels.
		 *
		 * @param  mixed $notifiable
		 * @return array
		 */
		public function via($notifiable)
		{
			return ['mail', 'database'];
		}
		
		/**
		 * Get the mail representation of the notification.
		 *
		 * @param  mixed|\App\Client $notifiable
		 * @return \Illuminate\Notifications\Messages\MailMessage
		 */
		public function toMail($notifiable)
		{
			$totalCost = $this->order->items->sum(function (OrderItem $item) {
				return ($item->price_at_purchase * $item->quantity);
			});
			
			return (new MailMessage)
				->subject('New Purchase Order')
				->markdown('mail.order', ['order' => $this->order, 'totalCost' => $totalCost, 'client' => $notifiable]);
			//->line('Purchase of ' . $this->order->items->count() . ' products')
			//->line('Actual balance: KES ' . number_format($actual, 2))
			//->line('Spending limit: KES ' . number_format($limit, 2))
			//->line('Amount settled: KES ' . number_format($spent, 2))
			//->line('Amount blocked: KES ' . number_format($blocked, 2))
			//->action('View Orders', url('/#/orders'))
			//->line('Thank you for using our application!');
		}
		
		/**
		 * Get the array representation of the notification.
		 *
		 * @param  mixed $notifiable
		 * @return array
		 */
		public function toArray($notifiable)
		{
			return [
				//
			];
		}
	}
