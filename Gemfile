source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'
gem 'rails', '~> 6.1.1'
gem 'pg'
gem 'puma'
gem 'bootsnap', require: false
gem 'grape'
gem 'grape-entity'
gem 'grape-kaminari'
gem 'grape_logging'
gem 'pry-rails'
gem 'rack'
gem 'rack-cas'
gem 'rack-cors', require: 'rack/cors'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'foreman'
  gem 'parallel_tests'
  gem 'rspec-core'
  gem 'rails-controller-testing'
  gem 'rspec-github'
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
  gem 'shoulda-matchers'
end

group :development do
  gem 'web-console'
  gem 'rack-mini-profiler'
  gem 'listen'
end

group :test do
  gem 'simplecov', require: false
  gem 'timecop'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
