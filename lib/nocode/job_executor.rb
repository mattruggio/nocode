# frozen_string_literal: true

require_relative 'context'
require_relative 'steps_executor'

module Nocode
  # Manages the lifecycle and executes a job.
  class JobExecutor
    PARAMETERS_KEY = 'parameters'
    REGISTERS_KEY  = 'registers'
    STEPS_KEY      = 'steps'

    attr_reader :yaml, :io

    def initialize(yaml, io: $stdout)
      @yaml = yaml.respond_to?(:read) ? yaml.read : yaml
      @yaml = YAML.safe_load(@yaml) || {}
      @io   = io

      freeze
    end

    def execute
      steps      = yaml[STEPS_KEY] || []
      parameters = yaml[PARAMETERS_KEY] || {}
      registers  = yaml[REGISTERS_KEY] || {}

      context = Context.new(
        io: io,
        parameters: parameters,
        registers: registers
      )

      log_title(context)

      StepsExecutor.new(context: context, steps: steps).execute

      context.log("Ended: #{DateTime.now}")
      context.log_line

      context
    end

    private

    def log_title(context)
      context.log_line

      context.log('Nocode Execution')
      context.log("Started: #{DateTime.now}")

      context.log_line
    end
  end
end
