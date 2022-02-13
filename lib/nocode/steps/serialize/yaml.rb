# frozen_string_literal: true

module Nocode
  module Steps
    module Serialize
      # Take the contents of a register and serialize it as YAML.  The serialized YAML
      # will override the register specified.
      class Yaml < Step
        option :register

        def perform
          input = registers[register_option]

          registers[register_option] = input.to_yaml
        end
      end
    end
  end
end
