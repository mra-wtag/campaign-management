require 'grape_logging'
require 'grape-kaminari'

module API
  class Dispatch < Grape::API
    PAGINATION_MAX_PER_PAGE = 300
    PAGINATION_DEFAULT_PER_PAGE = 50
    
    format :json

    include Grape::Kaminari
    include API::ExceptionHandling

    #
    # Strong Parameters
    #
    def permitted_params
      declared(params, include_missing: false)
    end

    def resource_params
      permitted_params.except(:page, :per_page, :offset)
    end

    #
    # Pagination
    #
    before do
      # grape-kaminari will always return a page header of the given per_page param
      # and not the really used (and maybe enforced) value
      if params[:per_page] && params[:per_page].to_i > PAGINATION_MAX_PER_PAGE
        params[:per_page] = PAGINATION_MAX_PER_PAGE
      end

      # grape-kaminari will not return a header with the default value of 50 if there was no
      # per_page param
      unless params[:per_page]
        params[:per_page] = PAGINATION_DEFAULT_PER_PAGE
      end
    end

    #
    # Authentication

    # http_basic do |username, password|
    #   user = ApiUser.find_by_username username
    #   user && user.authenticate(password)
    # end

    #
    # Resources
    #
    mount API::Resources::Ping

    route :any, '*path' do
      error!({ error:  'Not Found',
               detail: "No such route '#{request.path}' Found",
               status: 404 },
             404)
    end

    route :any do
      error!({ error:  'Not Found',
               detail: "No such route '#{request.path}' Found",
               status: 404 },
             404)
    end
  end

  Base = Rack::Builder.new do
    use GrapeLogging::Middleware::RequestLogger,
        logger: Rails.logger.dup,
        formatter: GrapeLogging::Formatters::Json.new,
        include: [
          GrapeLogging::Loggers::FilterParameters.new,
          GrapeLogging::Loggers::RequestHeaders.new,
          GrapeLogging::Loggers::ClientEnv.new,
        ]
    run API::Dispatch
  end
end