class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
        add_index :usuarios, :email, unique: true
  end
end
