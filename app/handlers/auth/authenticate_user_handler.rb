# frozen_string_literal: true

module Auth
  class AuthenticateUserHandler
    prepend SimpleCommand

    def initialize(access_token:)
      @access_token = access_token
    end

    def call; end
  end
end
