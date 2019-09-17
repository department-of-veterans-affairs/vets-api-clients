@extends('layouts.master')
@section('content')
@if(null !== Session::get('expires_at') and Session::get('expires_at') > time())
<div class="site-top-nav-wrapper site-l-wrapper ">
  <nav class="site-header__nav">
    <ul class="site-header__nav-list">
      <li class="site-header__nav-item">
        <a class="site-header__nav-item__link " href="https://developer.va.gov">Documentation</a>
      </li>
      @if(null !== Session::get('expires_at') and Session::get('expires_at') > time())
          <li class="site-header__nav-item">
            <a class="site-header__nav-item__link " href="/claims">View Claims</a>
          </li>
      @endif
    </ul>
  </nav>
</div>

@endif

<div class="site-hero clip-bottom">
  <div class="site-l-wrapper">
      <h1 class="vads-u-measure--1 vads-u-font-family--sans">A PHP sample app for the Lighthouse api</h1>
      <p class="va-introtext vads-u-measure--2 vads-u-font-family--sans">A working sample application for examples of Oauth, Benefits, and Benefit Intake API's in PHP and the Laravel web framework.</p>
      <p><a class="usa-button usa-button-big" href="/">Get started by logging in</a></p>
  </div>
</div>
@endsection
