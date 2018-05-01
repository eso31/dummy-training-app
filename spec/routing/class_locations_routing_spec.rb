require 'rails_helper'

RSpec.describe ClassLocationsController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(:get => '/class_locations').to route_to('class_locations#index')
    end

    it 'routes to #new' do
      expect(:get => '/class_locations/new').to route_to('class_locations#new')
    end

    it 'routes to #show' do
      expect(:get => '/class_locations/1').to route_to('class_locations#show', :id => '1')
    end

    it 'routes to #edit' do
      expect(:get => '/class_locations/1/edit').to route_to('class_locations#edit', :id => '1')
    end

    it 'routes to #create' do
      expect(:post => '/class_locations').to route_to('class_locations#create')
    end

    it 'routes to #update via PUT' do
      expect(:put => '/class_locations/1').to route_to('class_locations#update', :id => '1')
    end

    it 'routes to #update via PATCH' do
      expect(:patch => '/class_locations/1').to route_to('class_locations#update', :id => '1')
    end

    it 'routes to #destroy' do
      expect(:delete => '/class_locations/1').to route_to('class_locations#destroy', :id => '1')
    end

  end
end
