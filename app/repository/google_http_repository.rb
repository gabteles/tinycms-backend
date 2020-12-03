# frozen_string_literal: true

class GoogleHttpRepository
  include Dry::Monads[:result]

  def fetch_user_by_access_token(access_token)
    response = HTTParty.get('https://www.googleapis.com/oauth2/v1/userinfo', query: { access_token: access_token })
                       .parsed_response
                       .deep_symbolize_keys

    return Failure(:could_not_verify_access_token) if response[:error]

    Success(
      name: response[:name],
      picture: response[:picture],
      email: response[:email].downcase
    )
  end
end
