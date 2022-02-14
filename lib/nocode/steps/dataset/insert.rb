# frozen_string_literal: true

module Nocode
  module Steps
    module Dataset
      # Insert the entries to the at_index of the specified register.
      # If at_index is nil then they will appended to the end.
      class Insert < Step
        option :at_index, :entries, :register

        def perform
          registers[register_option] = array(registers[register_option])

          registers[register_option].insert(at_index, *entries)
        end

        private

        def entries
          array(entries_option)
        end

        def at_index
          at_index_option.nil? ? -1 : at_index_option.to_i
        end
      end
    end
  end
end
