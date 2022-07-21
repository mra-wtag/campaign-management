module API
  module Resources
    class Ping < Grape::API
      desc 'Ping? Pong!'
      get :ping do
        { pong: Time.now }
      end
    end
  end
end