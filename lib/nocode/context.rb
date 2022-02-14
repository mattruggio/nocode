# frozen_string_literal: true

module Nocode
  # Describes the environment for each running step.  An instance is initialized when a job
  # kicks off and then is passed from step to step.
  class Context
    PARAMETERS_KEY = 'parameters'
    REGISTERS_KEY  = 'registers'

    attr_reader :io,
                :parameters,
                :registers

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
      parameters[key]
    end

    def to_h
      {
        REGISTERS_KEY => registers,
        PARAMETERS_KEY => parameters
      }
    end
  end
end
