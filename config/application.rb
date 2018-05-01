require_relative 'boot'
require_relative '../app/helpers/application_form_builder'

require 'rails/all'
# we need to redefine the  activerecord-import#import method because it colides with elasticsaarch-model#import
#  more info https://github.com/zdennis/activerecord-import/issues/149
require 'activerecord-import/base'
class ActiveRecord::Base
  class << self
    alias :ar_import :import
    remove_method :import
  end
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TrainingApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    ActionView::Base.default_form_builder = ApplicationFormBuilder

  end
end
