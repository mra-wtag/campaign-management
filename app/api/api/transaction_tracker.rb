module API
  class TransactionTracker
    FILE_PATH = 'log/api_tracker.log'
    ERROR_CODES = [404, 405, 406, 500].freeze
    
    def initialize(app)
      @app = app
    end

    def call(env)
      response = @app.call(env)
      route = "#{env['REQUEST_METHOD']} #{env['REQUEST_PATH']}"
      track_api_request(route, response)
      response
    rescue => error
      log_and_report(error)
    end

    def track_api_request(grape_api_endpoint, response)
      status_code = response[0]
      report_api_transaction(grape_api_endpoint, status_code)
    rescue => error
      log_and_report(error)
    end

    def report_api_transaction(route, status_code)
      info_to_track = "#{route}, Status Code: #{status_code}, Time: #{DateTime.now.utc}"
      File.write(FILE_PATH, info_to_track, File.size(FILE_PATH), mode: 'a')
      File.write(FILE_PATH, "\n", File.size(FILE_PATH), mode: 'a')
    end

    def log_and_report(error)
      Rails.logger.error error.to_s
    end
  end
end
