class CreateProyects < ActiveRecord::Migration
  def change
    create_table :proyects do |t|
      t.text :name
      t.text :description
      t.integer :value
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :proyects, [:user_id, :created_at]
  end
end
