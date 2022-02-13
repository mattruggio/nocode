# frozen_string_literal: true

module Nocode
  module Util
    # Loads a directory full of Ruby classes and returns their relative paths.
    class ClassLoader
      EXTENSION = '.rb'

      attr_reader :dir

      def initialize(dir)
        @dir = dir

        freeze
      end

      def load!
        Dir[File.join(dir, '**', "*#{EXTENSION}")].sort.map do |step_path|
          require step_path

          step_path
            .delete_prefix(dir)
            .delete_prefix(File::SEPARATOR)
            .delete_suffix(EXTENSION)
        end
      end
    end
  end
end
