# frozen_string_literal: true

module Nocode
  module Steps
    module Dataset
      # Add entries specified in the options to the end of the specified register's
      # existing entries.
      class Append < Step
        option :entries, :register

        def perform
          registers[register_option] = array(registers[register_option])

          array(entries_option).each do |entry|
            registers[register_option].append(entry)
          end
        end
      end
    end
  end
end
