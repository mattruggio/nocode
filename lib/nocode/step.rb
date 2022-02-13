# frozen_string_literal: true

module Nocode
  class Step
    extend Forwardable
    include Util::Arrayable
    include Util::Optionable

    attr_reader :name, :context, :options, :type

    def_delegators :context, :parameters, :registers, :io

    def initialize(
      context: Context.new,
      name: '',
      options: {},
      type: ''
    )
      @context = context
      @options = options
      @name    = name
      @type    = type
    end
  end
end
