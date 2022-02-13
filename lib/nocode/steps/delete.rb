# frozen_string_literal: true

module Nocode
  module Steps
    class Delete < Step
      option :register

      def perform
        registers.delete(register_option)
      end
    end
  end
end
