# frozen_string_literal: true

module Nocode
  module Steps
    module Io
      # Read a file from disk and place its contents in a register.
      class Read < Step
        option :path,
               :register

        def perform
          data = File.read(path)

          registers[register_option] = data
        end

        private

        def path
          File.join(*array(path_option))
        end
      end
    end
  end
end
