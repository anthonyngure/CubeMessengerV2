<?php
	
	namespace App\Notifications;
	
	use App\Bill;
	use Illuminate\Bus\Queueable;
	use Illuminate\Contracts\Queue\ShouldQueue;
	use Illuminate\Notifications\Messages\MailMessage;
	use Illuminate\Notifications\Notification;
	
	class BillCanceledNotification extends Notification implements ShouldQueue
	{
		use Queueable;
		/**
		 * @var \App\Bill
		 */
		private $bill;
		
		/**
		 * Create a new notification instance.
		 *
		 * @param \App\Bill $bill
		 */
		public function __construct(Bill $bill)
		{
			//
			$this->bill = $bill;
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
			return (new MailMessage)
				->subject('Bill canceled')
				->markdown('mail.bills.canceled', ['bill' => $this->bill, 'client' => $notifiable]);
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
