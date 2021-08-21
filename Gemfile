ruby File.read(".ruby-version").strip

source 'https://rubygems.org'

gem 'rails','~> 6'
gem 'workflow', '~> 2.0'#, github: 'geekq/workflow'
gem 'workflow-activerecord', '>=4.1', '< 6.0'

# Using community gems because official support does not cover Rails 5
# Consider refactor not to use them or find alternatives.
# Gems hindering Rails 6 upgrade:
#
#gem 'rocket_pants', git: 'https://github.com/parse/rocket_pants'

gem 'protected_attributes_continued'

#The `content_tag_for` method has been removed from Rails. To continue using it, add the `record_tag_helper` gem to your Gemfile:
gem 'record_tag_helper'

# Other Gem issues:
gem 'font-awesome-sass', '< 5' # https://fontawesome.com/how-to-use/on-the-web/setup/upgrading-from-version-4

gem 'active_model_serializers'
gem 'activeadmin'
gem 'acts-as-taggable-on'
gem 'ancestry'#, github: 'stefankroes/ancestry'
gem 'authority'#, github: 'nathanl/authority'
gem 'bitmask_attributes'
gem 'bootsnap'
gem 'bootstrap4-kaminari-views'
gem 'chartkick'
gem 'cocoon'
gem 'coderay'
gem 'countries', require: 'countries/global'
gem 'country_select'
gem 'dalli'
gem 'discourse_api'
gem 'doorkeeper'
gem 'dotenv-rails'
gem 'dragonfly'#, '~> 1.1.1'
gem 'dragonfly-s3_data_store'
gem 'fast_jsonapi' # To support new v2 JSONAPI
gem 'flatpickr'
gem 'font-awesome-rails'
gem 'friendly_id'
gem 'groupdate' #used by chartkick
gem 'geocoder'
gem 'gibbon'
gem 'haml-rails'
gem 'hpricot'
gem 'http_accept_language'
gem 'inherited_resources'
gem 'invisible_captcha'
gem 'jbuilder'
gem 'jquery-rails'
gem 'kaminari'
gem 'letter_opener'
gem 'momentjs-rails' # Remove? It is already included with Chart.js bundle
gem 'nest'
gem 'paper_trail'
gem 'pg'
gem 'pg_search'
gem 'premailer-rails'
gem 'puma'
gem 'rack-attack'
gem 'rack-cache'
gem 'rack-cors', require: 'rack/cors'
gem 'ransack'
gem 'recaptcha'
gem 'redcarpet'
gem 'redis'
gem 'rolify'
gem 'rspec'
gem 'sass-rails'
gem 'sentry-ruby'
gem 'sentry-rails'
gem 'sidekiq'
gem 'simplecov', :require => false, :group => :test
gem 'simple_form'
gem 'sitemap_generator'
gem 'slim'
gem 'sort_alphabetical'
gem 'sprockets'
gem 'sprockets-rails'
gem 'stamp'
gem 'timezone'#, '~> 1.0'
gem 'trumbowyg_rails'#, git: 'https://github.com/TikiTDO/trumbowyg_rails.git'
gem 'twitter'
gem 'uglifier'#, '>= 1.3.0'

gem "paperclip"#, "~> 4.2"
# For paperclip/refile we need:
gem 'aws-s3'
gem 'aws-sdk-v1' # Can be used together with v2 because of different namespaces.

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  gem 'bullet' #, github: 'flyerhzm/bullet'
  gem "i18n-tasks", "~> 0.9.33"
  gem 'net-ssh'
  gem 'web-console'
  gem 'rack-mini-profiler'
end

group :test, :development do
  gem 'byebug'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'minitest'
  gem 'pry'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'test-unit'
  gem 'webmock'
  gem 'zonebie'
end

# Use ActiveModel has_secure_password
gem 'bcrypt'

# gem 'foreman'
# gem 'unicorn'

# Use unicorn as the app server
# gem 'unicorn'
