<?php

    require 'vendor/autoload.php';
    use GuzzleHttp\Client;

    $pdf_content =  file_get_contents("21x21.pdf");
    $lines = ["------WebKitFormBoundaryVfOwzCyvug0JmWYo",
        'Content-Disposition: form-data; name="metadata"; filename="metadata.json"',
        "Content-Type: application/json",
        "",
        '{"veteranFirstName": "Jane","veteranLastName": "Doe","fileNumber": "012345678","zipCode": "97202","source": "MyVSO","docType": "21-22"}',
        '------WebKitFormBoundaryVfOwzCyvug0JmWYo',
        'Content-Disposition: form-data; name="content"; filename="VBA200996_201902.pdf"',
        'Content-Type: application/pdf',
        "",
        $pdf_content,
        '------WebKitFormBoundaryVfOwzCyvug0JmWYo--'
    ];

    $data = implode("\r\n",$lines);
    $encoded = 'data:multipart/form-data;base64,' . base64_encode( $data );
    $url = 'https://dev-api.va.gov/services_user_content/vba_documents/9bbb17ae-2426-4b06-8a4d-a94c090ca7fa?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAKRBJFOP7HSQH6CBQ%2F20191011%2Fus-gov-west-1%2Fs3%2Faws4_request&X-Amz-Date=20191011T124137Z&X-Amz-Expires=900&X-Amz-SignedHeaders=host&X-Amz-Signature=d9178e8714c57e4edd6269a9926b32e5ed8b80cde1ef8635ba66f522d3136840';

    /// EXAMPLE WITH PHP GUZZLE
    // $client = new Client(['timeout'  => 60.0]);
    // $response = $client->put($url, [ 'body' => $encoded ]);
    // print_r($response);


    /// EXAMPLE WITH PHP CURL

    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PUT');
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $encoded);
    $response = curl_exec($ch);

    echo $response;
?>
