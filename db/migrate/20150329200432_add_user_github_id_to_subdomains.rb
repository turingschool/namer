class AddUserGithubIdToSubdomains < ActiveRecord::Migration
  def change
    add_column :subdomains, :user_github_id, :integer
    remove_column :subdomains, :user_id, :integer
  end
end
