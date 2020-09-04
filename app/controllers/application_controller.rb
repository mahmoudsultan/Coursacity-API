# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

  def resource_not_found
    not_found_error = { resource: ['Resource is not found.'] }
    render json: { errors: not_found_error }, status: 404
  end
end
