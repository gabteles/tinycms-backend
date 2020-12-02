# frozen_string_literal: true

module Auth
  class AuthenticateUserHandler
    include Dry::Transaction

    step :fetch_user_from_google

    private

    def fetch_user_from_google(access_token:)
      # TODO
    end
  end
end
