module Searchable
  extend ActiveSupport::Concern
  included do

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name([Rails.env, base_class.to_s.pluralize.underscore].join('_'))

  end
end