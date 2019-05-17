class AddOauthCallbackToAuthentications < ActiveRecord::Migration[5.2]
  def change
    add_reference :authentications, :oauth_callback, foreign_key: true
  end
end
