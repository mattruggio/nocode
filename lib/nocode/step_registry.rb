# frozen_string_literal: true

require_relative 'step'

# This will execute the StepRegisty's load! method upon script evaluation.
module Nocode
  # Provides a global place to register all valid steps by their types.  By default the
  # steps directory will be autoloaded and their paths will be used as their types.  For example:
  # for the class: steps/io/write, it would register as "io/write" type.
  class StepRegistry < Util::ClassRegistry
    include Singleton

    PREFIX = 'Nocode::Steps::'
    DIR    = File.join(__dir__, 'steps')

    class << self
      extend Forwardable

      def_delegators :instance,
                     :register,
                     :constant!,
                     :add,
                     :load!
    end

    def load!
      files_loaded = Util::ClassLoader.new(DIR).load!

      # Class the parent to load up the registry with the files we found.
      load(files_loaded, PREFIX)
    end
  end

  # Call upon class evaluation to autoload all classes.
  StepRegistry.load!
end
