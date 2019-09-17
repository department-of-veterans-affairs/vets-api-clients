@extends('layouts.master')
@section('content')
<div class="usa-grid">
    <div class="usa-width-two-thirds">
      <div class="content">
        <h1 class='main'>Veteran Status</h1>
        <p>Veteran is: <b>{{ $status['attributes']['veteran_status'] }}</b><p>
      </div>
    </div>
</div>
@endsection
