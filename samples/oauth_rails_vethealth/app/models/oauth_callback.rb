class OauthCallback < ApplicationRecord
  serialize :response_body_raw

  has_one :authentication

  def auth(protect_secrets=true)
    pass =
      if protect_secrets
        '<shhhhhhh>'
      else
        ENV['va_developer_client_secret']
      end
    { username: ENV['va_developer_client_id'], password: pass }
  end

  def post_body
    @post_body ||= {
      code: self.code,
      state: self.state,
      grant_type: 'authorization_code',
      redirect_uri: 'http://localhost:3000/callback'
    }
  end

  def fetch_access_token!(session)
    oauth_post = HTTParty.post(self.oauth_url, { basic_auth: auth(false), body: post_body })
    self.response_body_raw = oauth_post.to_h
    self.response_code = oauth_post.code
    save!

    if oauth_post.ok?
      attributes = Authentication.attributes_from_oauth(oauth_post)
      self.build_authentication(attributes)
      if self.authentication.validate_session(session)
        self.authentication.save!
      end
    end
  end

  def response_body
    return @response_body if @response_body
    @response_body = response_body_raw.dup
    # the access_token allows requests to be made in the logged-in users name, so don't expose it to the web
    @response_body['access_token'] = "<secret token for accessing API>"
    @response_body
  end
end
