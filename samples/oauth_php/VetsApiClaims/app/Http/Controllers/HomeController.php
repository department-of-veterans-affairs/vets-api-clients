<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\OauthSession;

class HomeController extends Controller
{
    public function getIndex()
    {
        $nonce_base = bin2hex(random_bytes(20));
        session(['nonce_key' => $nonce_base]);
        session(['login_time' => time()]);
        $scope = 'openid profile offline_access claim.read claim.write service_history.read disability_rating.read veteran_status.read';
        $oauth_params = [
          'client_id' => env('VA_CLIENT_ID'),
          'nonce' => hash("sha256", $nonce_base . env('VA_CLIENT_SECRET')),
          'redirect_uri' => "http://localhost:3000/callback",
          'response_type' => 'code',
          'scope' => $scope,
          'state' => session('login_time')
        ];
        $oauth_url = env('VETS_API_URL') . "/oauth2/authorization?" . http_build_query($oauth_params);
        return view('home', ['oauth_url' => $oauth_url]);
    }

    public function getCallback(Request $request)
    {
      if ($request->input('code') == null) {
        return redirect("/");  
      };
      if ((int)$request->input('state') != session('login_time')) {
        session(['Invalid state' => 'Invalid State']);
        return redirect("/");
      }
      $body = [
        'grant_type' => 'authorization_code',
        'code' => $request->input('code'),
        'state' => $request->input('state'),
        'redirect_uri' => "http://localhost:3000/callback"
      ];
      $url = env('VETS_API_URL') . "/oauth2/token";
      $curl = curl_init($url);
      curl_setopt($curl, CURLOPT_USERPWD, env('VA_CLIENT_ID') . ":" . env('VA_CLIENT_SECRET'));
      curl_setopt($curl, CURLOPT_TIMEOUT, 30);
      curl_setopt($curl, CURLOPT_POST, 1);
      curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($body));
      curl_setopt($curl, CURLOPT_RETURNTRANSFER, TRUE);
      $res = curl_exec($curl);
      $httpcode = curl_getinfo($curl, CURLINFO_HTTP_CODE);
      curl_close($curl);
      $response = json_decode( $res, true );
      if ($httpcode / 400 == 1) {
        session(['alert' => "Login failed because " . $response['error']]);
        return redirect("/");
      }
      if ($httpcode != 200) {
        session(['alert' => "Authorization did not receive OK response.  Response in logs."]);
        return redirect("/");
      }
      $sesh = new OauthSession();
      $sesh->access_token = $response['access_token'];
      $sesh->token_type = $response['token_type'];
      $sesh->expires_at = $response['expires_at'];
      $sesh->scope = $response['scope'];
      $sesh->id_token = $response['id_token'];
      $sesh->state = $response['state'];
      $sesh->refresh_token = $response['refresh_token'];
      # unless sesh.id_token_attributes['nonce'] == digest(session[:nonce_key])
      #   flash.alert = 'Inauthentic token received.'
      #   session(['alert' => "Inauthentic token received."]);
      #   redirect_to(login_path) && return
      # end
      # sesh.save!
      $sesh->save();
      session(['id' => $sesh->id, 'expires_at' => $sesh->expires_at]);
      #$request->session()->put('id', 'value');
      return redirect("/claims");
    }

    public function destroy(Request $request)
    {
        $request->session()->flush();
        return redirect('/');
    }

}
