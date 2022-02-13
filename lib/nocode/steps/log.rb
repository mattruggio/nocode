# frozen_string_literal: true

module Nocode
  module Steps
    # Simply output the passed in message into the outputted log.
    class Log < Step
      option :message

      def perform
        io.puts(message_option.to_s)
      end
    end
  end
end
