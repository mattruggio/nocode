# frozen_string_literal: true

module Nocode
  module Steps
    module Io
      # Write the contents of a register to disk.
      class Write < Step
        option :path,
               :register

        def perform
          data = registers[register_option]

          FileUtils.mkdir_p(File.dirname(path))

          File.write(path, data)
        end

        private

        def path
          File.join(*array(path_option))
        end
      end
    end
  end
end
