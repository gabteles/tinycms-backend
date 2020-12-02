# frozen_string_literal: true

class ApplicationController < ActionController::API
  def dispatch_command(command)
    if command.invalid?
      render(json: { errors: command.errors.to_h }, status: :bad_request)
        .then { return }
    end

    render command_bus.call(command).either(
      ->(result) { { json: { result: result } } },
      ->(failure) { { json: { errors: failure }, status: :bad_request } }
    )
  end

  delegate :command_bus, to: 'Rails.configuration'
end
