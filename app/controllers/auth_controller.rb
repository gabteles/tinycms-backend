# frozen_string_literal: true

class AuthController < ApplicationController
  def access
    dispatch_command(Auth::AuthenticateUserCommand.new(params.to_unsafe_h))
  end
end
