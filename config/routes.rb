require './app/api/api.rb'

Rails.application.routes.draw do
  mount API::Base => '/api'
end
