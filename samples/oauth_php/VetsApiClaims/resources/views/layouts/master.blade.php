<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="/images/favicon.ico">
        <title>Lighthouse API PHP Sample</title>

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,600" rel="stylesheet">
        <link href="{{ asset('css/app.css') }}" rel="stylesheet">
        <link href="{{ asset('css/formation.min.css') }}" rel="stylesheet">
        <link href="{{ asset('css/design-va.css') }}" rel="stylesheet">

    </head>
    <body>
        <header class="site-header" role="banner">
          <div class="site-l-wrapper">
            <div class="site-header__masthead">
              <div class="site-header__logo" id="extended-logo">
                <em class="site-header__logo-text">
                  <a class="site-header__logo-link" title="VA.gov Design System homepage" href="/"><strong class="vads-u-display--block small-screen:vads-u-display--inline">Lighthouse</strong> <span class="vads-u-display--none small-screen:vads-u-display--inline">|</span> Oauth Example - PHP</a>
                </em>
              </div>
              <div class="site-header__utility-links">
                
                @if(null !== Session::get('expires_at') and Session::get('expires_at') > time())
                    <a href="/logout" class="usa-button site-button-inverse">Logout</a>
                @else
                    <a href="{{$oauth_url}}" class="usa-button site-button-inverse">Oauth Login</a>
                    <a href="https://github.com/department-of-veterans-affairs/vets-api-clients/blob/master/test_accounts.md" class="usa-button vads-u-margin--0" target="_BLANK">Test Users</a>
                @endif
              </div>
            </div>
          </div>
        </header>
        <main>
          <div class="large-screen:vads-u-padding-x--0">
            @if(null !== Session::get('expires_at') and Session::get('expires_at') > time())
            <div class="site-top-nav-wrapper site-l-wrapper ">
              <nav class="site-header__nav">
                <ul class="site-header__nav-list">
                  <li class="site-header__nav-item">
                    <a class="site-header__nav-item__link " href="https://developer.va.gov" target="_BLANK">Documentation</a>
                  </li>
                  @if(null !== Session::get('expires_at') and Session::get('expires_at') > time())
                      <li class="site-header__nav-item">
                        <a class="site-header__nav-item__link " href="/claims">View Claims</a>
                      </li>
                      <li class="site-header__nav-item">
                        <a class="site-header__nav-item__link " href="/verification">Veteran Verification</a>
                      </li>
                  @endif
                </ul>
              </nav>
            </div>

            @endif
            @yield('content')
          </div>
        </main>
        <footer class="site-footer vads-u-padding-y--5" role="contentinfo">
          <div class="site-l-wrapper">
            <div class="medium-screen:vads-u-display--flex medium-screen:vads-u-justify-content--space-between vads-u-align-items--center">
              <div>
                <ul class="site-footer__links">
                  <li class="site-footer__links__item"><a href="/documentation/whats-new">What’s new?</a></li>
                  <li class="site-footer__links__item"><a href="http://www.va.gov/playbook/" target="_blank">VA.gov playbook</a></li>
                  <li class="site-footer__links__item"><a target="_blank" href="https://www.section508.va.gov/">Accessibility</a></li>
                  <li class="site-footer__links__item"><a href="http://www.va.gov/web/" target="_blank">Web governance &amp; policies</a></li>
                  <li class="site-footer__links__item"><a href="http://www.va.gov/privacy/">Privacy</a></li>
                </ul>
              </div>
              <div class="footer-seal">
                <a href="https://va.gov" class="site-footer__logo" title="Go to VA.gov"><img src="/images/va-logo-white.png" alt="U.S. Department of Veterans Affairs logo"></a>
              </div>
          </div>
          </div>
        </footer>

    </body>
</html>

