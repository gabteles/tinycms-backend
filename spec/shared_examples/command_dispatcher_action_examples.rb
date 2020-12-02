# frozen_string_literal: true

RSpec.shared_examples 'command dispatcher action' do
  # When using this shared examples, define:
  # - command_class
  # - valid_params
  # - invalid_params
  # - response - Send `params` with the request

  context 'with invalid params' do
    let(:params) { invalid_params }

    it { is_expected.to be_bad_request }

    it 'will not dispatch the command using the command bus' do
      expect(command_bus).to receive(:call).with(instance_of(command_class)).never
      response
    end
  end

  context 'with valid params' do
    let(:params) { valid_params }

    let(:handler_response) { Success(nil) }

    before { allow(command_bus).to receive(:call).and_return(handler_response) }

    it 'dispatches the command using the command bus' do
      expect(command_bus).to receive(:call).with(instance_of(command_class))
      response
    end

    context 'when handler response is successful' do
      let(:handler_response) { Success(foo: 'bar') }

      it { is_expected.to be_successful }
      it { expect(response.body).to be_blank }
    end

    context 'when handler response is a failure' do
      let(:handler_response) { Failure(foo: ['bar']) }

      it { is_expected.to be_bad_request }
      it { expect(json_body).to have_key(:errors) }
      it { expect(json_body[:errors]).to eq handler_response.failure }
    end
  end
end
