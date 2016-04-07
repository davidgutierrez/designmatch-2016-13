class CreateDesigns < ActiveRecord::Migration
  def change
    create_table :designs do |t|
      t.text :email
      t.text :firstName
      t.text :lastName
      t.text :pictureOriginal
      t.text :pictureProcessed
      t.integer :offer
      t.text :state
      t.references :proyect, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :designs, [:proyect_id, :created_at]
  end
end
