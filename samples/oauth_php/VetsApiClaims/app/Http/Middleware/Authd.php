<?php

namespace App\Http\Middleware;

use Closure;

class Authd
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        if(null == $request->session()->get('id') or (null !== $request->session()->get('expires_at') and $request->session()->get('expires_at') < time())) {
            return redirect('/');
        }
        return $next($request);
    }
}
