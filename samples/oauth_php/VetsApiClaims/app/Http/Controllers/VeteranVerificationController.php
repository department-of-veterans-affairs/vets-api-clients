<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\OauthSession;
use GuzzleHttp\Exception\GuzzleException;
use GuzzleHttp\Client;

class VeteranVerificationController extends Controller
{
    public function index()
    {
        if (null !== session('id') and null !== session('expires_at') ) {
            $oauth_session = OauthSession::find(session('id'));
            $url = env('VETS_API_URL') . '/services/veteran_verification/v0/status';
            $client = new Client(['headers' => ['Authorization' => 'Bearer ' . $oauth_session->access_token]]);
            $response = $client->request('GET', $url);
            $status = json_decode($response->getBody()->getContents(), true);
            return view('veteran_status', ['status' => $status['data']]);
        } 
    }
    //
}
