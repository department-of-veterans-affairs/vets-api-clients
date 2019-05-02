module HealthApiHelper
  def header_bg_style(api_response)
    if api_response.code == 200
      'bg-light'
    else
      'bg-dark text-danger'
    end
  end
end
