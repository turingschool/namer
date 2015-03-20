class AddUserAttributes < ActiveRecord::Migration
  def change
    add_column :users, :github_id, :string
    add_column :users, :github_account, :string
    add_index :users, :github_id
  end
end
