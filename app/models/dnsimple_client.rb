class DNSimpleClient
  attr_reader :email, :token

  def initialize(email, token)
    @email = email
    @token = token
  end

  def register_subdomain(subdomain, content)
    #post to dnsimple; return dnsimple record id or error
  end

  def records
    #return all records for given thing
  end

  def http_client
    @http_client ||= Faraday.new(url: "https://api.dnsimple.com") do |conn|
                       conn.headers["X-DNSimple-Token"] = "#{email}:#{token}"
                       conn.headers["Accept"] = "application/json"
                     end
  end
end
