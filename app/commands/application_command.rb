# frozen_string_literal: true

class ApplicationCommand < Hash
  extend Forwardable
  def_delegators :command, :errors
  define_method(:invalid?) { command.failure? }

  class << self
    def new(params)
      command = @schema.call(params)
      self[command.to_h].tap { |instance| instance.send(:command=, command) }
    end

    def schema(&block)
      @schema = Dry::Schema.Params(&block)
    end
  end

  private

  attr_accessor :command
end
