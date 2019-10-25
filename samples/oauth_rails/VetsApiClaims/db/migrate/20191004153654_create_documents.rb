class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.string :guid
      t.string :status
      t.string :code
      t.string :message
      t.string :detail
      t.string :location
      t.string :username
      t.integer :claim_ref
      t.string :veteran_ref

      t.timestamps
    end
  end
end
