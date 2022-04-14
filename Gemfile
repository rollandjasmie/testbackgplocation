source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'

gem 'rails', '~> 6.0.4', '>= 6.0.4.1'

# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.3', '>= 4.3.9'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'os', '~> 1.1.1'
# Use Active Storage variant
gem 'image_processing', '~> 1.2'
gem 'useragent', '~> 0.16.7'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.9', '>= 3.9.1'
end

group :development do
  gem 'listen', '~> 3.2.1'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


gem 'rack-cors', '~> 1.1', '>= 1.1.1'

gem 'simple_token_authentication', '>= 1.17.0'
gem 'table_print'


# GEM for API authentication

gem 'jwt'
# gem 'bcrypt-ruby'
gem 'bcrypt', '~> 3.1', '>= 3.1.15'

group :test do
  gem 'factory_bot_rails', '~> 4.11', '>= 4.11.1'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'faker'
  gem 'database_cleaner'
end

#uploader une image
gem 'carrierwave'

#redimensionner une image
gem 'mini_magick'

#stripe
gem 'stripe'

#dotenv
gem 'dotenv-rails', '>= 2.7.6'

# grm pour api google


gem 'omniauth-google-oauth2'
gem 'devise', '>= 4.7.3'
gem 'omniauth'
gem 'signet'
gem 'rest-client' 
gem "letter_opener", "~> 1.7"

gem 'wicked_pdf'
# gem 'wkhtmltopdf-binary', github: 'pallymore/wkhtmltopdf-binary-edge', tag: 'v0.12.2'
gem 'wkhtmltopdf-binary-edge', '~> 0.12.6.0'

gem 'google-apis-core', '~> 0.3.0'
gem 'google-apis-analyticsreporting_v4', '~> 0.2.0'
gem 'google-analytics-data-v1alpha', '~> 0.8.0'
gem "aws-sdk-s3"