# frozen_string_literal: true

class ApplicationController < ActionController::API
  def dispatch_command(command)
    if command.invalid?
      render(json: { errors: command.errors.to_h }, status: :bad_request)
        .then { return }
    end

    # CQRS Key takeway: a command can safely return the following data:
    # - Execution result: success or failure;
    # - Error messages or validation errors, in case of a failure;
    # - The aggregate’s new version number, in case of success;
    render command_bus.call(command).either(
      ->(_result) { { head: :ok } },
      ->(failure) { { json: { errors: failure }, status: :bad_request } }
    )
  end

  delegate :command_bus, to: 'Rails.configuration'
end
