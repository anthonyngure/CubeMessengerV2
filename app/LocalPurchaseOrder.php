<?php
	
	namespace App;
	
	use Illuminate\Database\Eloquent\Model;
	
	/**
 * App\LocalPurchaseOrder
 *
 * @property int $id
 * @property int $supplier_id
 * @property \Carbon\Carbon|null $created_at
 * @property \Carbon\Carbon|null $updated_at
 * @property string|null $deleted_at
 * @property-read \Illuminate\Database\Eloquent\Collection|\App\LocalPurchaseOrderItem[] $items
 * @method static \Illuminate\Database\Eloquent\Builder|\App\LocalPurchaseOrder whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|\App\LocalPurchaseOrder whereDeletedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|\App\LocalPurchaseOrder whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|\App\LocalPurchaseOrder whereSupplierId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|\App\LocalPurchaseOrder whereUpdatedAt($value)
 * @mixin \Eloquent
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
	}
