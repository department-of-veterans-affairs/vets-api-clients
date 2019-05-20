class CreateOauthCallbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :oauth_callbacks do |t|
      t.boolean :verified_state
      t.string :code
      t.string :state
      t.string :oauth_url
      t.string :response_body_raw
      t.integer :response_code

      t.timestamps
    end
  end
end
