class AddWebPage < ActiveRecord::Migration
  def change
    add_column :users, :webPage, :string
  end
end
