class CreateAuthentications < ActiveRecord::Migration[5.2]
  def change
    create_table :authentications do |t|
      t.string :access_token
      t.string :token_type
      t.datetime :expires_at
      t.string :scope
      t.string :id_token
      t.string :state
      t.string :patient

      t.timestamps
    end
  end
end
