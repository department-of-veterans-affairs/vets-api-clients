@extends('layouts.master')
@section('content')
<div class="usa-grid">
    <div class="usa-width-two-thirds">
      <div class="content">
        <h1 class='main'>2122 Form</h1>
        <ul>
          <li>ID: {{$claim['id']}}</li>
          <li>Status: {{$claim['attributes']['status']}}</li>
          <li>Date Request Accepted: {{$claim['attributes']['date_request_accepted']}}</li>
        </ul>
        <hr />
        <form action={{'/poa_form/' . $claim['id']}} method="POST">
          {{ csrf_field() }}
          <input type="hidden" name="_method" id="_method" value="PUT">
          <label for="attachment">Add Supporting Document</label>
          <input type="file" name="attachment" id="attachment" value="">

          <input type="submit" name="submit" id="submit" value="Upload">
        </form>
      </div>
    </div>
</div>
@endsection
