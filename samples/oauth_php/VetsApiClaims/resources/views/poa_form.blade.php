@extends('layouts.master')
@section('content')
<div class="usa-grid">
    <div class="usa-width-two-thirds">
      <div class="content">
        <h1 class='main'>2122 Form Submission</h1>
        <form action="/poa" method="post">
          {{ csrf_field() }}
          <label for="poaCode">poaCode</label>
          <input required type="text" name="poaCode" id="poaCode" value="">
          <label for="poaFirstName">poaFirstName</label>
          <input required type="text" name="poaFirstName" id="poaFirstName" value="">
          <label for="poaLastName">poaLastName</label>
          <input required type="text" name="poaLastName" id="poaLastName" value="">
          <input type="submit" name="submit" id="submit" >
        </form>
      </div>
    </div>
</div>
@endsection
