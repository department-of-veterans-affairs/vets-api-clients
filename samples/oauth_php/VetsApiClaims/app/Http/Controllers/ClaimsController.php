<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\OauthSession;

class ClaimsController extends Controller
{
    public function index()
    {
        if (null !== session('id') and null !== session('expires_at') ) {
            $oauth_session = OauthSession::find(session('id'));
            $url = env('VETS_API_URL') . '/services/claims/v1/claims';
            $curl = curl_init($url);
            curl_setopt($curl, CURLOPT_TIMEOUT, 30);
            curl_setopt($curl, CURLOPT_RETURNTRANSFER, TRUE);
            curl_setopt($curl, CURLOPT_HTTPHEADER, array(
                'Authorization: Bearer ' . $oauth_session->access_token
            ));
            $res = curl_exec($curl);
            $httpcode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
            curl_close($curl);
            $claims = json_decode( $res, true );
            return view('claims', ['claims' => $claims['data']]);
        } 
    }
}
