<?php
	
	use Illuminate\Database\Migrations\Migration;
	use Illuminate\Database\Schema\Blueprint;
	
	class CreateLocalPurchaseOrdersTable extends Migration
	{
		/**
		 * Run the migrations.
		 *
		 * @return void
		 */
		public function up()
		{
			Schema::create('local_purchase_orders', function (Blueprint $table) {
				$table->increments('id');
				$table->unsignedInteger('supplier_id', false);
				$table->foreign('supplier_id')->references('id')->on('users');
				$table->string('lpo_pdf_path')->nullable();
				$table->string('delivery_note_path')->nullable();
				$table->timestamp('delivery_note_received_at')->nullable();
				$table->unsignedInteger('delivery_note_received_by_id', false)->nullable();
				$table->foreign('delivery_note_received_by_id')->references('id')->on('users');
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
			Schema::dropIfExists('local_purchase_orders');
		}
	}
