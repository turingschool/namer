class Subdomain < ActiveRecord::Base
  validates :subdomain, presence: true
  validates :content, presence: true
  validates :dnsimple_record_id, presence: true
  validates :user_id, presence: true
  belongs_to :user
end
