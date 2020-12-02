# frozen_string_literal: true

module Auth
  class AuthenticateUserCommand < ApplicationCommand
    schema do
      required(:access_token).filled(:string)
    end
  end
end
