class DocumentsController < ApplicationController
  before_action :require_auth
  before_action :setup_from_session

  def index
    @documents = Document.where(username: @session.id_token_attributes[:preferred_username])
  end

  def new
  end

  def create
    res = RestClient.post("https://dev-api.va.gov/services/vba_documents/v0/uploads", nil,  apikey: Figaro.env.va_api_key)
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
    encoded = Base64.encode64(file_contents)
    RestClient.put(@document.location,
                         "data:application/pdf;base64,#{encoded}",
                         {'Content-Encoding': 'base64',
                          'Content-Type': 'application/pdf'
    }
                        )
    redirect_to documents_path
  end

  def update_status
    document = Document.find params[:id]
    res = RestClient.get("https://dev-api.va.gov/services/vba_documents/v0/uploads/#{document.guid}",  apikey: Figaro.env.va_api_key)
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
      url: "https://dev-api.va.gov/services/vba_documents/v0/uploads/#{document.guid}/download",
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
end
