class AddUniquenessIndexToSubdomainsSubdomain < ActiveRecord::Migration
  def change
    add_index :subdomains, :subdomain, unique: true
  end
end
