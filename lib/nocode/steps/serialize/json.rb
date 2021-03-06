# frozen_string_literal: true

module Nocode
  module Steps
    module Serialize
      # Take the contents of a register and serialize it as JSON.  The serialized JSON
      # will override the register specified.
      class Json < Step
        option :register

        def perform
          input = registers[register_option]

          registers[register_option] = input.to_json
        end
      end
    end
  end
end
