require 'rails_helper'

RSpec.describe Series, type: :model do

  subject { create :series }

  it 'should validate required attributes' do
    should validate_presence_of(:name)

  end

end
