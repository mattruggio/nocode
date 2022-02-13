# frozen_string_literal: true

module Nocode
  module Steps
    module Deserialize
      # take a specified register and parse it as a CSV to produce an array of hashes.
      class Csv < Step
        option :register

        def perform
          input = registers[register_option].to_s

          registers[register_option] = CSV.new(input, headers: true).map(&:to_h)
        end
      end
    end
  end
end
