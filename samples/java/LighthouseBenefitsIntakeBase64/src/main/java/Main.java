
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Base64;
import org.apache.http.HttpEntity;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

public class Main {

    public static void main(String args[]) throws IOException {
        String fullPayload = buildPayload("my_pdf_path");
        String responseBody = sendRequest(fullPayload);
        System.out.println(responseBody);
    }

    public static String sendRequest(String payload) throws IOException {
        String documentUrl = "https://sandbox-api.va.gov/services_user_content/vba_documents/42050eab-b10a-4d48-a6ab-3fb0e65cd03f?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAQD72FDTFWPUWR5OZ%2F20200603%2Fus-gov-west-1%2Fs3%2Faws4_request&X-Amz-Date=20200603T114342Z&X-Amz-Expires=900&X-Amz-SignedHeaders=host&X-Amz-Signature=bee42f783f965b2427eb21436cc749d2653a84b3271dabc23ab193f65ec5f7c4";

        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPut httpPut = new HttpPut(documentUrl);
        httpPut.setHeader("Content-Type", "multipart/form-data");
        httpPut.setHeader("apiKey", "myapi_key");
        StringEntity stringEntity = new StringEntity(payload);
        httpPut.setEntity(stringEntity);

        ResponseHandler<String> responseHandler = response -> {
            int status = response.getStatusLine().getStatusCode();
            if (status >= 200 && status < 300) {
                HttpEntity entity = response.getEntity();
                return entity != null ? EntityUtils.toString(entity) : null;
            } else if (status == 403) {
                throw new ClientProtocolException("Response status: " + status + " Unauthorized");
            } else {
                throw new ClientProtocolException("Unexpected response status: " + status);
            }
        };
        return httpclient.execute(httpPut, responseHandler);
    }

    public static String buildPayload(String filePath) {
        try {
            byte[] data = Files.readAllBytes(Paths.get(filePath));
            String binaryData = new String(data);
            String newLine = "\r\n";
            String payload = "------WebKitFormBoundaryVfOwzCyvug0JmWYo"
                    .concat(newLine)
                    .concat("Content-Disposition: form-data; name='metadata'; filename='metadata.json'")
                    .concat(newLine)
                    .concat("Content-Type: application/json")
                    .concat(newLine)
                    .concat(newLine)
                    .concat("")
                    .concat(newLine)
                    .concat("{\"veteranFirstName\": \"Jane\",\"veteranLastName\": \"Doe\",\"fileNumber\": \"012345678\",\"zipCode\": \"97202\",\"source\": \"MyVSO\",\"docType\": \"21-22\"}")
                    .concat(newLine)
                    .concat("------WebKitFormBoundaryVfOwzCyvug0JmWYo")
                    .concat(newLine)
                    .concat("Content-Disposition: form-data; name='content'; filename='VBA200996_201902.pdf'")
                    .concat(newLine)
                    .concat("Content-Type: application/pdf")
                    .concat(newLine)
                    .concat("")
                    .concat(newLine)
                    .concat(binaryData)
                    .concat(newLine)
                    .concat("------WebKitFormBoundaryVfOwzCyvug0JmWYo--");
            String encodedPayload = Base64.getEncoder().encodeToString(payload.getBytes());
            return "data:multipart/form-data;base64,".concat(encodedPayload);
        } catch (IOException e) {
            return e.getLocalizedMessage();
        }
    }
}
