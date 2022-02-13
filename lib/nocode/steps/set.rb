# frozen_string_literal: true

module Nocode
  module Steps
    class Set < Step
      option :register, :value

      def perform
        registers[register_option] = value_option
      end
    end
  end
end
