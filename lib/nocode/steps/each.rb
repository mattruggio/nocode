# frozen_string_literal: true

module Nocode
  module Steps
    # Iterate over a register.  Each iteration will store the current element and index in
    # special registers called: _element and _index.  You can prefix these registers by setting
    # the element_register_prefix option.
    class Each < Step
      option :element_register_prefix,
             :register,
             :steps

      skip_options_evaluation!

      def perform
        entries.each_with_index do |entry, index|
          registers[element_key] = entry
          registers[index_key]   = index

          execute_steps
        end
      end

      private

      def execute_steps
        StepsExecutor.new(context: context, steps: steps).execute
      end

      def entries
        array(registers[register_option])
      end

      def steps
        array(steps_option)
      end

      def element_key
        "#{element_register_prefix_option}_element"
      end

      def index_key
        "#{element_register_prefix_option}_index"
      end
    end
  end
end
