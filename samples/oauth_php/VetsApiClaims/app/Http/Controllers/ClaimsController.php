<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\OauthSession;
use GuzzleHttp\Exception\GuzzleException;
use GuzzleHttp\Client;

class ClaimsController extends Controller
{
    public function index(Request $request)
    {
        if (null !== $request->session()->get('id') and null !== $request->session()->get('expires_at') ) {
            $oauth_session = OauthSession::find($request->session()->get('id'));
            $url = env('VETS_API_URL') . '/services/claims/v1/claims';
            $client = new Client(['headers' => ['Authorization' => 'Bearer ' . $oauth_session->access_token]]);
            $response = $client->request('GET', $url);
            $claims = json_decode($response->getBody()->getContents(), true);
            return view('claims', ['claims' => $claims['data']]);
        } 
    }
}
