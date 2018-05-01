# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :auth_hash, class: OmniAuth::AuthHash do
    provider 'google_oauth2'
    uid '100000000000000000000'
    info do
      {
        name: 'Google User',
        email: Faker::Internet.unique.email,
        first_name: 'Google',
        last_name: 'User',
        image: ''
      }
    end
    credentials do
      {
        token: 'token',
        refresh_token: 'another_token',
        expires_at: 1_354_920_555,
        expires: true
      }
    end
    extra do
      {
        # This huge chunk is used to test for CookieOverflow exception
        id_token: Array.new(1000) { 'string' }.join,
        raw_info: OmniAuth::AuthHash.new(
          email: 'test@example.com',
          email_verified: 'true',
          kind: 'plus#personOpenIdConnect',
          name: 'Test Person'
        )
      }
    end

    factory :admin_auth do
      info do
        {
          name: Faker::Simpsons.character,
          email: Faker::Internet.unique.email,
          first_name: 'Google',
          last_name: 'User',
          image: ''
        }
      end
    end
  end
end