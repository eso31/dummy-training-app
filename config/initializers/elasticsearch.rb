# :todo needs more investigation, because i am getting this error when trying to use it
#   ActionView::Template::Error ([400] No handler found for uri [//development_training_sessions/training_session/_search?from=0&q=ruby&size=15] and method [GET]):
#
# config = {
#     host: 'http://localhost:9300/',
#
# }
#
# if File.exists?('config/elasticsearch.yml')
#   config.merge!(YAML.load_file('config/elasticsearch.yml')[Rails.env].symbolize_keys)
# end
#
# Elasticsearch::Model.client = Elasticsearch::Client.new(config)

Elasticsearch::Model.client = Elasticsearch::Client.new(
  url: ENV['ELASTICSEARCH_SERVICE'] || 'http://localhost:9200'
)
