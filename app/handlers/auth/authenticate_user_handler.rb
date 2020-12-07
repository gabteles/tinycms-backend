# frozen_string_literal: true

module Auth
  class AuthenticateUserHandler
    include Dry::Transaction
    include Inject[:google_repository]

    step :fetch_user_from_google
    step :register_user

    private

    def fetch_user_from_google(access_token:)
      google_repository.fetch_user_by_access_token(access_token)
    end

    def register_user(data); end
  end
end
