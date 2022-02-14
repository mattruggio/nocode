# frozen_string_literal: true

module Nocode
  module Steps
    module Dataset
      # Combine all specified from_registers into one dataset and place in the specified
      # to_register.  If anything currently exists in the to_register then it will be coerced
      # to an array and prepended to the beginning.
      class Coalesce < Step
        option :from_registers, :to_register

        def perform
          registers[to_register_option] = array(registers[to_register_option])

          array(from_registers_option).each do |from_register|
            registers[to_register_option] += array(registers[from_register])
          end
        end
      end
    end
  end
end
