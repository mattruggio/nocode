# frozen_string_literal: true

module Nocode
  # Defines a running step.  Steps should be sub-classes of this class as well as to implement
  # #perform.
  class Step
    extend Forwardable
    include Util::Arrayable
    include Util::Optionable

    attr_reader :context,
                :name,
                :options,
                :type

    def_delegators :context,
                   :io,
                   :parameters,
                   :registers

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
