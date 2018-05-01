# frozen_string_literal: true

require 'rails_helper'
require 'ostruct'
RSpec.describe User do
  subject { create :user }

  it 'validates presence of attributes' do
    should validate_presence_of(:email)
    should validate_presence_of(:first_name)
    should validate_presence_of(:last_name)
  end

  it 'validate default role' do
    expect(subject.has_role?(:user)).to be_truthy
  end

  describe 'from_omniauth' do

    let(:omniauth) do
      OpenStruct.new(provider: 'google_oauth2',
                     uid: '104402270173354173173',
                     info: OpenStruct.new(full_name: 'Juan Lopez',
                                          email: 'juan@nearsoft.com',
                                          first_name: 'Juan',
                                          last_name: 'Lopez',
                                          image: 'https://lh6.googleusercontent.com/-EXTRAINFO/AAAAAAAAAAI/FOOOOBAR/BLABLA/photo.jpg',
                                          urls: {
                                            google: 'https://plus.google.com/1732454317322'
                                          }))
    end

    it 'should get existing user' do
      User.create(email: 'foo@bar.com',
                  password: 'secret',
                  first_name: 'super',
                  last_name: 'man',
                  image: 'flying-pic.jpg')

      access_token = OpenStruct.new
      access_token.info = OpenStruct.new(email: 'foo@bar.com')
      u = User.from_omniauth(access_token)
      expect(u.email).to eq('foo@bar.com')
    end

    it "should create the user if doesn't exists" do
      expect(User.exists?(email: omniauth.info.email)).to be_falsey

      u = User.from_omniauth(omniauth)

      expect(User.exists?(email: omniauth.info.email)).to be_truthy
      expect(u.email).to eq(omniauth.info.email)
    end
  end

end
