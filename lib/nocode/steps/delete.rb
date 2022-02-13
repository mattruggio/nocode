# frozen_string_literal: true

module Nocode
  module Steps
    # Remove a register completely.
    class Delete < Step
      option :register

      def perform
        registers.delete(register_option)
      end
    end
  end
end
