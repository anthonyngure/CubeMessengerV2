<?php
	
	namespace App\Notifications;
	
	use App\Order;
	use Illuminate\Bus\Queueable;
	use Illuminate\Notifications\Messages\MailMessage;
	use Illuminate\Notifications\Notification;
	
	class OrderDeliveredNotification extends Notification
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
			return ['mail'];
		}
		
		/**
		 * Get the mail representation of the notification.
		 *
		 * @param  mixed $notifiable
		 * @return \Illuminate\Notifications\Messages\MailMessage
		 */
		public function toMail($notifiable)
		{
			return (new MailMessage)
				->subject('Order Confirmed Delivered')
				->greeting('Order Confirmed Delivered')
				->line('Your order number ' . $this->order->id . ' has been confirmed delivered!')
				//->action('Notification Action', url('/'))
				->line('Thank you for using our application!');
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
