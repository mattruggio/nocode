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

      # rubocop:disable Metrics/AbcSize
      def perform
        entries = array(registers[register_option])

        entries.each_with_index do |entry, index|
          steps = array(steps_option)

          registers["#{element_register_prefix_option}_element"] = entry
          registers["#{element_register_prefix_option}_index"]   = index

          StepsExecutor.new(context: context, steps: steps).execute
        end
      end
      # rubocop:enable Metrics/AbcSize
    end
  end
end
