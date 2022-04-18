# frozen_string_literal: true

class AddRefreshTokenInSessions < ActiveRecord::Migration[5.2]
  def change
    add_column :sessions, :refresh_token, :string
  end
end
