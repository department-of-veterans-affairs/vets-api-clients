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

    public function poa_form(Request $request)
    {
        return view('poa_form', []);
    }

    public function poa_form_show(Request $request, $id)
    {
        $oauth_session = OauthSession::find($request->session()->get('id'));
        $url = env('VETS_API_URL') . '/services/claims/v1/forms/2122/' . $id;
        $client = new Client(['headers' => ['Authorization' => 'Bearer ' . $oauth_session->access_token]]);
        $response = $client->request('GET', $url);
        $claim = json_decode($response->getBody()->getContents(), true)['data'];
        return view('poa_form_show', ['claim' => $claim]);
    }

    public function poa_form_upload(Request $request, $id)
    {
        return redirect()->route('poa_form_show', ['id' => $id]);
    }

    public function poa(Request $request)
    {
        $poaCode = $request->poaCode;
        $poaFirstName = $request->poaFirstName;
        $poaLastName  = $request->poaLastName;
        $oauth_session = OauthSession::find($request->session()->get('id'));
        $url = env('VETS_API_URL') . '/services/claims/v1/forms/2122';
        $client = new Client(['headers' => ['Authorization' => 'Bearer ' . $oauth_session->access_token]]);
        $response = $client->request(
            'POST', $url, [
            'json' => [
              'data' => [
                'attributes' => [
                  'poaCode' => $poaCode,
                  'poaFirstName' => $poaFirstName,
                  'poaLastName' => $poaLastName
                ]
              ]
            ]
            ]
        );
        $claim = json_decode($response->getBody()->getContents(), true)['data'];
        return redirect()->route('poa_form_show', ['id' => $claim['id']]);
    }
}
