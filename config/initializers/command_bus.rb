# frozen_string_literal: true

Rails.configuration.to_prepare do
  Rails.configuration.command_bus = Arkency::CommandBus.new.tap do |bus|
    bus.register(Auth::AuthenticateUserCommand, Auth::AuthenticateUserHandler)
  end
end
