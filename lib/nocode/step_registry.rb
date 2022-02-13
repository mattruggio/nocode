# frozen_string_literal: true

require_relative 'step'

module Nocode
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

      load(files_loaded, PREFIX)
    end
  end

  StepRegistry.load!
end
