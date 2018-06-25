<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateLocalPurchaseOrderItemsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('local_purchase_order_items', function (Blueprint $table) {
            $table->increments('id');
	        $table->unsignedInteger('local_purchase_order_id', false);
	        $table->foreign('local_purchase_order_id')->references('id')->on('local_purchase_orders');
	        $table->unsignedInteger('order_item_id', false);
	        $table->foreign('order_item_id')->references('id')->on('order_items');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('local_purchase_order_items');
    }
}
