# frozen_string_literal: true

module ApiException
  extend ActiveSupport::Concern

  included do
    rescue_from Exceptions::GiftNotFound,
                Exceptions::AlreadyAssignGift,
                Exceptions::EmployeeNotFound, with: :handle_api_exceptions

    def handle_api_exceptions(exception)
      if /NotFound/.match?(exception.class.name)
        respond_with_error message: exception.message, status: 404
      elsif /AlreadyAssignGift/.match?(exception.class.name)
        respond_with_error message: exception.message, status: 400
      else
        error_message = if Rails.env.development?
          exception.message
        else
          "Something went wrong. Please try again later."
        end
        respond_with_error message: error_message
      end
    end

    def respond_with_error(message:, status: 500)
      render json: { error: message }, status: status
    end
  end
end
