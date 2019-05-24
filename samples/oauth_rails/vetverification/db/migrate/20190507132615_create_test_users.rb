class CreateTestUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :test_users do |t|
      t.string :first_name
      t.string :last_name
      t.string :ssn
      t.date :birth_date
      t.string :edipi
      t.string :poa
      t.string :email

      t.timestamps
    end
  end
end
