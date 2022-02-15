# frozen_string_literal: true

module Nocode
  module Steps
    module Io
      # List all files in the path option.  Wildcards can be used.
      #
      # Mechanic: https://ruby-doc.org/core-2.5.0/Dir.html#method-c-glob
      class List < Step
        option :path,
               :register

        def perform
          registers[register_option] = Dir[path].reject { |p| File.directory?(p) }
        end

        private

        def path
          File.join(*array(path_option))
        end
      end
    end
  end
end
