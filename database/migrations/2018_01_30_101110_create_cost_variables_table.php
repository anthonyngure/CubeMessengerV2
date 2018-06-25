<?php
	
	use Illuminate\Database\Migrations\Migration;
	use Illuminate\Database\Schema\Blueprint;
	
	class CreateCostVariablesTable extends Migration
	{
		/**
		 * Run the migrations.
		 *
		 * @return void
		 */
		public function up()
		{
			Schema::create('cost_variables', function (Blueprint $table) {
				$table->increments('id');
				$table->string('name')->unique();
				$table->double('value', 8, 2);
				$table->boolean('public')->default(true);
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
			Schema::dropIfExists('cost_variables');
		}
	}
