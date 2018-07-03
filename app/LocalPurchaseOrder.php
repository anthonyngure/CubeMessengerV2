<?php
	
	namespace App;
	
	use Illuminate\Database\Eloquent\Model;
	
	/**
 * App\LocalPurchaseOrder
 *
 * @property int                                                                         $id
 * @property int                                                                         $supplier_id
 * @property \Carbon\Carbon|null                                                         $created_at
 * @property \Carbon\Carbon|null                                                         $updated_at
 * @property string|null                                                                 $deleted_at
 * @property-read \Illuminate\Database\Eloquent\Collection|\App\LocalPurchaseOrderItem[] $items
 * @method static \Illuminate\Database\Eloquent\Builder|\App\LocalPurchaseOrder whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|\App\LocalPurchaseOrder whereDeletedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|\App\LocalPurchaseOrder whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|\App\LocalPurchaseOrder whereSupplierId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|\App\LocalPurchaseOrder whereUpdatedAt($value)
 * @mixin \Eloquent
 * @property string|null $lpo_pdf_path
 * @property string|null $lpo_generated_at
 * @property string|null $delivery_note_path
 * @property string|null $delivery_note_received_at
 * @property int|null $delivery_note_received_by_id
 * @property-read \App\User $supplier
 * @method static \Illuminate\Database\Eloquent\Builder|\App\LocalPurchaseOrder whereDeliveryNotePath($value)
 * @method static \Illuminate\Database\Eloquent\Builder|\App\LocalPurchaseOrder whereDeliveryNoteReceivedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|\App\LocalPurchaseOrder whereDeliveryNoteReceivedById($value)
 * @method static \Illuminate\Database\Eloquent\Builder|\App\LocalPurchaseOrder whereLpoGeneratedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|\App\LocalPurchaseOrder whereLpoPdfPath($value)
 * @property string|null $invoice_pdf_path
 * @method static \Illuminate\Database\Eloquent\Builder|\App\LocalPurchaseOrder whereInvoicePdfPath($value)
 */
	class LocalPurchaseOrder extends Model
	{
		//
		
		protected $fillable = ['supplier_id'];
		
		/**
		 * @return \Illuminate\Database\Eloquent\Relations\HasMany
		 */
		public function items()
		{
			return $this->hasMany(LocalPurchaseOrderItem::class);
		}
		
		public function supplier()
		{
			return $this->belongsTo(User::class, 'supplier_id');
		}
	}
