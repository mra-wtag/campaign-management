module API
  module ExceptionHandling
    extend ActiveSupport::Concern

    included do
      rescue_from Grape::Exceptions::ValidationErrors do |e|
        response = { status: 422, message: e.message }
        rack_response response.to_json, 422
      end

      rescue_from ActiveRecord::RecordInvalid do |error|
        error!(error.record.errors.full_messages.to_sentence, 422, 'Content-Type' => 'application/json')
      end

      rescue_from ActiveRecord::RecordNotFound do |error|
        Rails.logger.error error.message
        Rails.logger.error error.backtrace.join("\n")
        error!(error.message, 404, 'Content-Type' => 'application/json')
      end
    end
  end
end