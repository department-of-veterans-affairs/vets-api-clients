class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.string :access_token
      t.string :token_type
      t.datetime :expires_at
      t.string :scope
      t.string :id_token
      t.string :state

      t.timestamps
    end
  end
end
