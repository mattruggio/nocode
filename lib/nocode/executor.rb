# frozen_string_literal: true

require_relative 'context'
require_relative 'object_template'
require_relative 'step_registry'

module Nocode
  class Executor
    attr_reader :yaml, :io

    def initialize(yaml, io: $stdout)
      @yaml = yaml.respond_to?(:read) ? yaml.read : yaml
      @yaml = YAML.safe_load(@yaml) || {}
      @io   = io

      freeze
    end

    def execute
      steps      = yaml['steps'] || []
      parameters = yaml['parameters'] || {}
      context    = Context.new(io: io, parameters: parameters)

      log_title

      steps.each do |step|
        step_instance = make_step(step, context)

        execute_step(step_instance)
      end

      log("Ended: #{DateTime.now}")
      log_line

      context
    end

    private

    def make_step(step, context)
      step       = ObjectTemplate.new(step).evaluate(context.to_h)
      type       = step['type'].to_s
      name       = step['name'].to_s
      options    = step['options'] || {}
      step_class = StepRegistry.constant!(type)

      step_class.new(
        options: Util::Dictionary.new(options),
        context: context,
        name: name,
        type: type
      )
    end

    def execute_step(step)
      log(step.name) unless step.name.empty?
      log("Step:  #{step.type}")
      log("Class: #{step.class}")

      time_in_seconds = Benchmark.measure { step.perform }.real

      log("Completed in #{time_in_seconds.round(3)} second(s)")

      log_line
    end

    def log_title
      log_line

      log('Nocode Execution')
      log("Started: #{DateTime.now}")

      log_line
    end

    def log_line
      log('-' * 50)
    end

    def log(msg)
      io.puts(msg)
    end
  end
end
