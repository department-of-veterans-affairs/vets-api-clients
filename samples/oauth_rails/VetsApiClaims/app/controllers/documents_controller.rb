class DocumentsController < ApplicationController
  before_action :require_auth
  before_action :setup_from_session

  def index
    @documents = Document.all.order(created_at: :asc) # where(username: @session.id_token_attributes[:preferred_username])
  end

  def new
  end

  def create
    res = RestClient.post("https://sandbox-api.va.gov/services/vba_documents/v0/uploads", nil,  apikey: Figaro.env.va_api_key)
    parsed = JSON.parse(res.body)['data']
    Document.create(
      guid: parsed['attributes']['guid'],
      status: parsed['attributes']['status'],
      location: parsed['attributes']['location'],
      username: @session.id_token_attributes[:preferred_username]
    )
    redirect_to documents_path
  end

  def edit
    @document = Document.find params[:id]
  end

  def update
    @document = Document.find params[:id]
    file_contents = File.read( params[:upload].tempfile.path )
    content = build_content(file_contents.chop)
    encoded = Base64.encode64(content)
    RestClient.put(@document.location,
                         "data:multipart/form-data;base64,#{encoded}",
                         {'Content-Encoding': 'base64',
                          'Content-Type': 'application/pdf'
    }
                    )
    redirect_to documents_path
  end

  def update_status
    document = Document.find params[:id]
    res = RestClient.get("https://sandbox-api.va.gov/services/vba_documents/v0/uploads/#{document.guid}",  apikey: Figaro.env.va_api_key)
    parsed = JSON.parse(res.body)['data']
    document.update(
      status: parsed['attributes']['status'],
      code: parsed['attributes']['code'],
      detail: parsed['attributes']['detail'],
      updated_at: parsed['attributes']['updated_at']
    )
    redirect_to documents_path
  end

  def download
    document = Document.find params[:id]
    raw = RestClient::Request.execute(
      method: :get,
      url: "https://sandbox-api.va.gov/services/vba_documents/v0/uploads/#{document.guid}/download",
      raw_response: true,
      headers: {
        apikey: Figaro.env.va_api_key
      }
    )
    send_file raw.file.path, type: 'Application/pdf'
  end

  def destroy
    @document = Document.find params[:id]
    @document.destroy
    redirect_to documents_path
  end

  private
  def build_content(content)
    ["------WebKitFormBoundaryVfOwzCyvug0JmWYo",
     'Content-Disposition: form-data; name="metadata"; filename="metadata.json"',
     "Content-Type: application/json",
     "",
     '{"veteranFirstName": "Jane","veteranLastName": "Doe","fileNumber": "012345678","zipCode": "97202","source": "MyVSO","docType": "21-22"}',
     '------WebKitFormBoundaryVfOwzCyvug0JmWYo',
     'Content-Disposition: form-data; name="content"; filename="VBA200996_201902.pdf"',
     'Content-Type: application/pdf',
     "",
     content.chomp("\r\n"),
     '------WebKitFormBoundaryVfOwzCyvug0JmWYo--',
    ].join("\r\n") + "\r\n"
  end
end
