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
end

group :development do
  gem 'web-console'
  gem 'rack-mini-profiler'
  gem 'listen'
end

group :test do

end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
