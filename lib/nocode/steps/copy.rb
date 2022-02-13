# frozen_string_literal: true

module Nocode
  module Steps
    # Shallow-copy one register to another.
    class Copy < Step
      option :from_register, :to_register

      def perform
        registers[to_register_option] = registers[from_register_option].dup
      end
    end
  end
end
