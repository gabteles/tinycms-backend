# frozen_string_literal: true

RSpec.describe ApplicationController, type: :controller do
  describe '#dispatch_command' do
    controller do
      define_method(:index) { dispatch_command(command) }
      define_method(:command) {}
    end

    let(:foo_command) do
      Class.new(ApplicationCommand) do
        schema { required(:foo).filled(:string) }
      end
    end

    it_behaves_like 'command dispatcher action' do
      subject(:response) { get :index }
      let(:command) { foo_command.new(params) }

      before { allow(controller).to receive(:command).and_return(command) }

      let(:command_class) { foo_command }
      let(:valid_params) { { foo: 'bar' } }
      let(:invalid_params) { {} }
    end
  end
end
