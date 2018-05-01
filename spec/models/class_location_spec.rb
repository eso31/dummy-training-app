require 'rails_helper'

RSpec.describe ClassLocation, type: :model do
  subject { described_class.new(name: 'Don Mina (HMO)', email: 'donmina@nearsoft.com', timezone: 'America/Hermosillo') }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'validates presence of attributes' do
    should validate_presence_of(:name)
    should validate_presence_of(:email)
  end

end
