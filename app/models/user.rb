class User
  attr_reader :github_id, :github_name, :email, :github_token, :authed_at

  def initialize(attributes)
    attributes = ActiveSupport::HashWithIndifferentAccess.new(attributes)
    @github_id = attributes[:github_id]
    @github_name = attributes[:github_name]
    @email = attributes[:email]
    @github_token = attributes[:github_token]
    @authed_at = attributes[:authed_at] || Time.now
  end

  def as_json(options={})
    {github_id: github_id, github_name: github_name,
     email: email, github_token: github_token, authed_at: authed_at}
  end

  def to_json
    as_json.to_json
  end

  def subdomains
    Subdomain.where(user_github_id: github_id)
  end

  def inspect
    "Turing GH User: #{github_name}, gh id: #{github_id}, email #{email}, token: #{github_token}"
  end
end
