# The first thing you need to configure is which modules you need in your app.
# The default is nothing which will include only core features
# (password encryption, login/logout).
# Available submodules are: :user_activation, :http_basic_auth, :remember_me,
# :reset_password, :session_timeout, :brute_force_protection,
# :activity_logging, :external

SERVER = "http://0.0.0.0:3000"

Rails.application.config.sorcery.submodules = [:external]

# Here you can configure each submodule's features.
Rails.application.config.sorcery.configure do |config|
  config.external_providers = [:github]

  config.github.key = "758bf4e3a20127d7b9cd"
  config.github.secret = "a7730dc40a055fefc512ab6cc7617228073715d4"
  config.github.callback_url = "#{SERVER}/oauth/callback?provider=github"
  config.github.user_info_mapping = { email: :email }

  # --- user config ---
  config.user_config do |user|
    user.authentications_class = Authentication
  end

  # This line must come after the 'user config' block.
  # Define which model authenticates with sorcery.
  config.user_class = "User"
end
