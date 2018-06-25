<?php
	
	namespace App;
	
	use Illuminate\Database\Eloquent\Model;
	use Illuminate\Database\Eloquent\SoftDeletes;
	
	/**
 * App\SubscriptionType
 *
 * @mixin \Eloquent
 * @property int                                                                         $id
 * @property string                                                                      $name
 * @property int                                                                         $delivery_base_cost Base cost for delivering the item to the client
 * @property \Carbon\Carbon|null                                                         $created_at
 * @property \Carbon\Carbon|null                                                         $updated_at
 * @property-read \Illuminate\Database\Eloquent\Collection|\App\SubscriptionOptionItem[] $subscriptionItems
 * @method static \Illuminate\Database\Eloquent\Builder|\App\SubscriptionOption whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|\App\SubscriptionOption whereDeliveryBaseCost($value)
 * @method static \Illuminate\Database\Eloquent\Builder|\App\SubscriptionOption whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|\App\SubscriptionOption whereName($value)
 * @method static \Illuminate\Database\Eloquent\Builder|\App\SubscriptionOption whereUpdatedAt($value)
 * @property-read \Illuminate\Database\Eloquent\Collection|\App\SubscriptionOptionItem[] $items
 * @property int $delivery_cost Base cost for delivering the item to the client
 * @property string|null $description
 * @method static \Illuminate\Database\Eloquent\Builder|\App\SubscriptionOption whereDeliveryCost($value)
 * @method static \Illuminate\Database\Eloquent\Builder|\App\SubscriptionOption whereDescription($value)
 * @property string|null $deleted_at
 * @method static \Illuminate\Database\Eloquent\Builder|\App\SubscriptionOption whereDeletedAt($value)
 * @method static bool|null forceDelete()
 * @method static \Illuminate\Database\Query\Builder|\App\SubscriptionOption onlyTrashed()
 * @method static bool|null restore()
 * @method static \Illuminate\Database\Query\Builder|\App\SubscriptionOption withTrashed()
 * @method static \Illuminate\Database\Query\Builder|\App\SubscriptionOption withoutTrashed()
 */
	class SubscriptionOption extends Model
	{
		//
		use SoftDeletes;
		/**
		 * @return \Illuminate\Database\Eloquent\Relations\HasMany
		 */
		public function items()
		{
			return $this->hasMany(SubscriptionOptionItem::class);
		}
	}
