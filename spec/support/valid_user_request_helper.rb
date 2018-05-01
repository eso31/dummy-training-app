# Module for authenticating users for request specs.
module ValidUserRequestHelper

  # Sign in as a user with Google OAuth
  def sign_in_oauth(role = :user, options = {})
    sign_in_user_driver options.key?(:user) ? options[:user] : create(role)
  end

  # Signs in a the user passed on the params
  def sign_in_user_driver(user)

    # Make the config
    OmniAuth.config.test_mode = true
    set_oauth_user user

    # Set the values in the headers
    if @request
      set_request_env(user)
    else
      set_rails_env
    end
  end

  private

  def set_oauth_user(user)
    OmniAuth.config.mock_auth[:google_oauth2] = build(:auth_hash) do |u|
      u.info.email = user.email
    end
  end

  def set_rails_env
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]

    post '/users/auth/google_oauth2/callback'
  end

  def set_request_env(user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]

    sign_in user
  end

end