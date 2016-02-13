class AddRememberDigestToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :remember_digest, :string
  end
end
