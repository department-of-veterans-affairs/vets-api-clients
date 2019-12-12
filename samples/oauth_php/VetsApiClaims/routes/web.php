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
Route::get('/claims', ['middleware' => 'oauth_auth', 'uses' => 'ClaimsController@index']);
Route::get('/poa_form', ['middleware' => 'oauth_auth', 'uses' => 'ClaimsController@poa_form'])->name('poa_form');
Route::get('/poa_form/{id}', ['middleware' => 'oauth_auth', 'uses' => 'ClaimsController@poa_form_show'])->name('poa_form_show');
Route::get('/verification', ['middleware' => 'oauth_auth', 'uses' => 'VeteranVerificationController@index']);
Route::get('/logout', 'HomeController@destroy');

Route::put('/poa_form/{id}', ['middleware' => 'oauth_auth', 'uses' => 'ClaimsController@poa_form_upload'])->name('poa_form_upload');
Route::post('/poa', ['middleware' => 'oauth_auth', 'uses' => 'ClaimsController@poa'])->name('poa_form_create');
