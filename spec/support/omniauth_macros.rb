module OmniauthMacros

  def mock_auth_hash(provider, has_email = true)
    auth_data = { 'provider' => provider, 'uid' => '123456789' }
    auth_data['info'] = { 'email' => has_email } if has_email

    OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new(auth_data)
  end

end