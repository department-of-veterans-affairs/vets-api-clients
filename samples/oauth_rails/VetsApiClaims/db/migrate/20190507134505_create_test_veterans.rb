# frozen_string_literal: true

class CreateTestVeterans < ActiveRecord::Migration[5.2]
  def change
    create_table :test_veterans do |t|
      t.string :first_name
      t.string :last_name
      t.string :ssn
      t.date :birth_date
      t.string :edipi
      t.string :poa

      t.timestamps
    end
  end
end
