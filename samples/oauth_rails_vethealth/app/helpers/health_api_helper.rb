module HealthApiHelper
  def header_bg_style(api_response)
    if api_response.code == 200
      'bg-success'
    else
      'bg-light'
    end
  end
end
