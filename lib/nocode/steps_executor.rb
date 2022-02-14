# frozen_string_literal: true

require_relative 'step_registry'

module Nocode
  # Class that knows how to execute a series of steps given a context.
  class StepsExecutor
    extend Forwardable

    NAME_KEY    = 'name'
    OPTIONS_KEY = 'options'
    TYPE_KEY    = 'type'

    attr_reader :context, :steps

    def_delegators :context, :io

    def initialize(context:, steps:)
      @context = context
      @steps   = steps

      freeze
    end

    def execute
      steps.each do |step|
        step_instance = make_step(step)

        execute_step(step_instance)
      end
    end

    private

    # TODO: It could be better encapsulated to move the evaluation logic into the step itself
    # and let it deal with compilation.  This may call for re-working the lifecycle of the Step
    # class so I will temporarily defer this refactoring.
    def make_step(step)
      evaluated_step = Util::ObjectTemplate.new(step).evaluate(context.to_h)
      type           = evaluated_step[TYPE_KEY].to_s
      name           = evaluated_step[NAME_KEY].to_s
      step_class     = StepRegistry.constant!(type)

      options =
        if step_class.skip_options_evaluation?
          step[OPTIONS_KEY]
        else
          evaluated_step[OPTIONS_KEY]
        end

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

    def log_line
      log('-' * 50)
    end

    def log(msg)
      io.puts(msg)
    end
  end
end
