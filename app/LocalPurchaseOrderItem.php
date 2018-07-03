<?php
	
	namespace App;
	
	use Illuminate\Database\Eloquent\Model;
	
	/**
 * App\LocalPurchaseOrderItem
 *
 * @property int                 $id
 * @property int                 $local_purchase_order_id
 * @property int                 $order_item_id
 * @property \Carbon\Carbon|null $created_at
 * @property \Carbon\Carbon|null $updated_at
 * @property string|null         $deleted_at
 * @method static \Illuminate\Database\Eloquent\Builder|\App\LocalPurchaseOrderItem whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|\App\LocalPurchaseOrderItem whereDeletedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|\App\LocalPurchaseOrderItem whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|\App\LocalPurchaseOrderItem
 *         whereLocalPurchaseOrderId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|\App\LocalPurchaseOrderItem whereOrderItemId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|\App\LocalPurchaseOrderItem whereUpdatedAt($value)
 * @mixin \Eloquent
 * @property-read \App\OrderItem $orderItem
 * @property int                 $received
 * @method static \Illuminate\Database\Eloquent\Builder|\App\LocalPurchaseOrderItem whereReceived($value)
 */
	class LocalPurchaseOrderItem extends Model
	{
		protected $fillable = ['order_item_id'];
		
		
		public function orderItem()
		{
			return $this->belongsTo(OrderItem::class);
		}
	}
