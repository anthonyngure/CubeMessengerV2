<?php
	
	namespace App\Notifications;
	
	use App\LocalPurchaseOrder;
	use App\User;
	use Illuminate\Bus\Queueable;
	use Illuminate\Contracts\Queue\ShouldQueue;
	use Illuminate\Notifications\Messages\MailMessage;
	use Illuminate\Notifications\Notification;
	
	class LPONotification extends Notification implements ShouldQueue
	{
		use Queueable;
		private $supplier;
		/**
		 * @var \App\LocalPurchaseOrder
		 */
		private $lpo;
		
		/**
		 * Create a new notification instance.
		 *
		 * @param \App\LocalPurchaseOrder $lpo
		 * @param \App\User               $supplier
		 */
		public function __construct(LocalPurchaseOrder $lpo, User $supplier)
		{
			$this->supplier = $supplier;
			$this->lpo = $lpo;
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
		 * @param  mixed $notifiable
		 * @return \Illuminate\Notifications\Messages\MailMessage
		 */
		public function toMail($notifiable)
		{
			$items = $this->lpo->items()->with('orderItem.product')->get();
			
			return (new MailMessage)
				->subject('LPO from CubeMessenger')
				->markdown('mail.lpo', ['items' => $items, 'supplier' => $this->supplier]);
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
