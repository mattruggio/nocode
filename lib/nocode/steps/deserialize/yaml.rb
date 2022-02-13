# frozen_string_literal: true

module Nocode
  module Steps
    module Deserialize
      # Take a specified register and parse it as YAML to produce Ruby object(s).
      #
      # NOTE: This will throw an error if unsafe YAML types are used.  The only allowed types are
      # array, hash, strings, numbers, booleans, nil.  See:
      # https://ruby-doc.org/stdlib-2.6.1/libdoc/psych/rdoc/Psych.html#method-c-safe_load
      class Yaml < Step
        option :register

        def perform
          input = registers[register_option]

          registers[register_option] = YAML.safe_load(input)
        end
      end
    end
  end
end
