@extends('layouts.master')
@section('content')
<div class="usa-grid">
    <div class="usa-width-two-thirds">
      <div class="content">
        <h1 class='main'>Claims</h1>
        <table>
            <thead>
                <tr>
                    <th scope="col">Evss Id</th>
                    <th scope="col">Date Filed</th>
                    <th scope="col">Claim Type</th>
                    <th scope="col">Status</th>
                </tr>
            </thead>
            @foreach ($claims as $claim)
                <tr>
                    <td scope="row">{{$claim['attributes']['evss_id'] }}</td>
                    <td>{{$claim['attributes']['date_filed'] }}</td>
                    <td>{{$claim['attributes']['claim_type'] }}</td>
                    <td>{{$claim['attributes']['status'] }}</td>
                <tr>
            @endforeach
        </table>
      </div>
    </div>
</div>
@endsection
