class CreateSubdomains < ActiveRecord::Migration
  def change
    create_table :subdomains do |t|
      t.integer :dnsimple_record_id
      t.string :content
      t.references :user, index: true
      t.string :subdomain

      t.timestamps null: false
    end
    add_foreign_key :subdomains, :users
  end
end
