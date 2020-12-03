# frozen_string_literal: true

RSpec.describe GoogleHttpRepository, type: :repository do
  let(:instance) { described_class.new }

  describe '#fetch_user_by_access_token' do
    subject { instance.fetch_user_by_access_token(access_token) }

    let(:access_token) do
      'ya29.a0AfH6SMCc93t6Bdbn_xx7ZkyZgCzteB7OLRHpf5Am1k3AjNlkpzFlpWQLg8m_Xu7' \
      'Tri7TiisXFIxyrBHQEl9j0gL5VYoIJ0VChOznzNYrKtIDdN0c2TZ591DMV-zDHTux4_6tj' \
      '9joMw7ixPWU6ysu-0i4AzpdFdc3TG9CWNoXvagH'
    end

    context 'when token is valid' do
      before do
        stub_request(:get, 'https://www.googleapis.com/oauth2/v1/userinfo')
          .with(query: { access_token: access_token })
          .to_return(
            headers: { content_type: 'application/json' },
            body: {
              id: '110854775860411193486',
              email: 'bruce@wayne.co',
              verified_email: true,
              name: 'Bruce Wayne',
              given_name: 'Bruce',
              family_name: 'Wayne',
              picture: 'https://lh3.googleusercontent.com/a-/AOh14GgIdoPu7p',
              locale: 'pt-BR'
            }.to_json
          )
      end

      it { is_expected.to be_success }

      it 'correctly fetch service data' do
        expect(subject.value!).to eq(
          name: 'Bruce Wayne',
          picture: 'https://lh3.googleusercontent.com/a-/AOh14GgIdoPu7p',
          email: 'bruce@wayne.co'
        )
      end
    end

    context 'when token is invalid or expired' do
      before do
        stub_request(:get, 'https://www.googleapis.com/oauth2/v1/userinfo')
          .with(query: { access_token: access_token })
          .to_return(
            headers: { content_type: 'application/json' },
            status: :forbidden,
            body: {
              error: {
                code: 401,
                message: 'Request is missing required authentication credential. Expected OAuth 2' \
                         ' access token, login cookie or other valid authentication credential. S' \
                         'ee https://developers.google.com/identity/sign-in/web/devconsole-project.',
                status: 'UNAUTHENTICATED'
              }
            }.to_json
          )
      end

      it { is_expected.to be_failure }

      it 'correctly fetch service data' do
        expect(subject.failure).to eq(:could_not_verify_access_token)
      end
    end
  end
end
