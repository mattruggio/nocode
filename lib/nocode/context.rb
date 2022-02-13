# frozen_string_literal: true

module Nocode
  class Context
    attr_reader :io, :parameters, :registers

    def initialize(io: $stdout, parameters: {}, registers: {})
      @io         = io || $stdout
      @parameters = Util::Dictionary.ensure(parameters)
      @registers  = Util::Dictionary.ensure(registers)

      freeze
    end

    def register(key)
      registers[key]
    end

    def parameter(key)
      parameters(key)
    end

    def to_h
      {
        'registers' => registers,
        'parameters' => parameters
      }
    end
  end
end
