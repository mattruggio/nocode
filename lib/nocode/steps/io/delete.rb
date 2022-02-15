# frozen_string_literal: true

module Nocode
  module Steps
    module Io
      # Delete the specified path.  Does nothing if the file does not exist.
      class Delete < Step
        option :path

        def perform
          return if path.to_s.empty?

          FileUtils.rm_f(path) if File.exist?(path)
        end

        private

        def path
          File.join(*array(path_option))
        end
      end
    end
  end
end
