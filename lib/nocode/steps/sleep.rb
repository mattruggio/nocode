# frozen_string_literal: true

module Nocode
  module Steps
    class Sleep < Step
      option :seconds

      def perform
        Kernel.sleep(seconds_option.to_f)
      end
    end
  end
end
