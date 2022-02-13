# frozen_string_literal: true

module Nocode
  module Steps
    module Serialize
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
