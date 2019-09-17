@extends('layouts.master')
@section('content')
<div class="usa-grid">
    <div class="usa-width-two-thirds">
      <div class="content">
        <h1 class='main'>Claims</h1>
        <table>
            <tr>
                <th>Evss id</th>
                <th>Date Filed</th>
                <th>Claim Type</th>
                <th>Status</th>
            <tr>
            @foreach ($claims as $claim)
                <tr>
                    <td>{{$claim['attributes']['evss_id'] }}</td>
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
