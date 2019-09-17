<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', 'HomeController@getIndex');
Route::get('/callback', 'HomeController@getCallback');
Route::get('/claims', 'ClaimsController@index');
Route::get('/verification', 'VeteranVerificationController@index');
Route::get('/logout', 'HomeController@destroy');
