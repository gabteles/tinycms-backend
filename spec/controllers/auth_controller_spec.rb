# frozen_string_literal: true

RSpec.describe AuthController, type: :controller do
  describe 'POST #access' do
    it_behaves_like 'command dispatcher action' do
      subject(:response) { post :access, params: params }

      let(:command_class) { Auth::AuthenticateUserCommand }
      let(:valid_params) { { access_token: 'foobar' } }
      let(:invalid_params) { { access_token: nil } }
    end
  end
end
