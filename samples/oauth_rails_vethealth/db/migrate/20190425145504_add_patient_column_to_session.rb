class AddPatientColumnToSession < ActiveRecord::Migration[5.2]
  def change
    add_column :sessions, :patient, :string
  end
end
