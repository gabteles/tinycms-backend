# frozen_string_literal: true

class ApplicationController < ActionController::API
  def dispatch_command(command)
    if command.invalid?
      render(json: { errors: command.errors.to_h }, status: :bad_request)
        .then { return }
    end

    Rails.configuration.command_bus.call(command)
         .then { |operation| render_operation_result(operation) }
  end

  private

  def render_operation_result(operation)
    if operation.success?
      render(json: { result: operation.result })
    else
      render(json: { errors: operation.errors }, status: :bad_request)
    end
  end
end
