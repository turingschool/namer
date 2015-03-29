class Subdomain < ActiveRecord::Base
  validates :subdomain, presence: true, uniqueness: true
  validates :content, presence: true
  validates :dnsimple_record_id, presence: true, uniqueness: true
  validates :user_github_id, presence: true
  #belongs_to :user

  def register!
    #TODO: register the domain with DNSimple
  end
end
