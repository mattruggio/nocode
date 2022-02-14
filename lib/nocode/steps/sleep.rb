# frozen_string_literal: true

module Nocode
  module Steps
    # Sleep for an arbitrary number of seconds.
    #
    # Mechanic: https://apidock.com/ruby/Kernel/sleep
    class Sleep < Step
      option :seconds

      def perform
        Kernel.sleep(seconds_option.to_f)
      end
    end
  end
end
