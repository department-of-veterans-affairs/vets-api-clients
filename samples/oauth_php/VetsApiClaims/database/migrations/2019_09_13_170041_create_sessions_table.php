<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateSessionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('oauth_sessions', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('access_token', 255);
            $table->string('token_type', 255);
            $table->dateTime('expires_at');
            $table->string('scope', 255);
            $table->string('id_token', 255);
            $table->string('state', 255);
            $table->string('refresh_token', 255);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('sessions');
    }
}
