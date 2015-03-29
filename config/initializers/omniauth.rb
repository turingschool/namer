Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :github, ENV['NAMER_GITHUB_ID'], ENV['NAMER_GITHUB_SECRET'], scope: "user"
end
