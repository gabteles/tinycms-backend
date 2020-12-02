# frozen_string_literal: true

RSpec.describe Auth::AuthenticateUserCommand, type: :command do
  subject { described_class.new(params) }

  # TODO: Replace by factory_bot params
  let(:valid_params) { { access_token: '123' } }

  context 'with valid params' do
    let(:params) { valid_params }
    it { is_expected.to_not be_invalid }
  end

  context 'when access token is invalid' do
    let(:params) { valid_params.merge(access_token: 123) }
    it { is_expected.to be_invalid }
    it { expect(subject.errors.to_h).to include(access_token: ['must be a string']) }
  end
end
