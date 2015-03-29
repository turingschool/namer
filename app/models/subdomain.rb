class Subdomain < ActiveRecord::Base
  validates :subdomain, presence: true, uniqueness: true
  validates :content, presence: true
  validates :dnsimple_record_id, presence: true, uniqueness: true
  validates :user_github_id, presence: true
  #belongs_to :user

  def register!
    begin
      record = DNSIMPLE.domains.create_record("turingapps.io",
                                              record_type: "CNAME",
                                              name: subdomain,
                                              content: content)
      if record && record.is_a?(Dnsimple::Struct::Record)
        self.dnsimple_record_id = record.id
      end
      save
    rescue Dnsimple::RequestError, ArgumentError
      errors.add(:subdomain, "sorry, couldn't register this subdomain with DNSimple. It may already be taken")
      false
    end
  end

  def deregister!
    Rails.logger.info("Going to de-register subdomain #{subdomain}.turingapps.io (DNSimple #{dnsimple_record_id})")
    begin
      response = DNSIMPLE.domains.delete_record("turingapps.io", dnsimple_record_id)
      if response.success?
        Rails.logger.info("DNSimple deregistration succeeded; will delete Subdomain db record")
        destroy
      else
        raise Dnsimple::RequestError.new(resp)
      end
      true
    rescue Dnsimple::RequestError, Dnsimple::NotFoundError => ex
      Rails.logger.info("DNSimple deregistration failed for #{subdomain}.turingapps.io (DNSimple record #{dnsimple_record_id}): #{ex}")
      false
    end
  end
end
