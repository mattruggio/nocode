# frozen_string_literal: true

module Nocode
  module Steps
    module Dataset
      # Add entries specified in the options to the beginning of the specified register's
      # existing entries.
      class Prepend < Step
        option :entries, :register

        def perform
          registers[register_option] = array(registers[register_option])

          array(entries_option).reverse_each do |entry|
            registers[register_option].prepend(entry)
          end
        end
      end
    end
  end
end
