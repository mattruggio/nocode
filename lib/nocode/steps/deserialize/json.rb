# frozen_string_literal: true

module Nocode
  module Steps
    module Deserialize
      # take a specified register and parse it as JSON to produce Ruby object(s).
      class Json < Step
        option :register

        def perform
          input = registers[register_option]

          registers[register_option] = JSON.parse(input)
        end
      end
    end
  end
end
