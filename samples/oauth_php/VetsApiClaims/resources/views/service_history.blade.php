@extends('layouts.master')
@section('content')
@if(null !== Session::get('expires_at') and Session::get('expires_at') > time())
<div class="site-top-nav-wrapper site-l-wrapper ">
  <nav class="site-header__nav">
    <ul class="site-header__nav-list">
      <li class="site-header__nav-item">
        <a class="site-header__nav-item__link " href="/documentation">Documentation</a>
      </li>
      @if(null !== Session::get('expires_at') and Session::get('expires_at') > time())
          <li class="site-header__nav-item">
            <a class="site-header__nav-item__link " href="/claims">View Claims</a>
          </li>
          <li class="site-header__nav-item">
            <a class="site-header__nav-item__link " href="/verfification">Veteran Verification</a>
          </li>
      @endif
    </ul>
  </nav>
</div>

@endif
<div class="usa-grid">
    <div class="usa-width-two-thirds">
      <div class="content">
        <h1 class='main'>Claims</h1>
        {{ var_dump($service_history[0]['attributes']) }}
      </div>
    </div>
</div>
@endsection

