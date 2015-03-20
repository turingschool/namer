class User < ActiveRecord::Base
  has_many :subdomains
end
