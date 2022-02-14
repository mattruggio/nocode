# frozen_string_literal: true

module Nocode
  module Steps
    module Dataset
      # Slice a dataset and keep on the entries between start_index and end_index, inclusively.
      # If start_index is not provided then it defaults to 0.
      # If end_index is not provided then it defaults to the end of the dataset.
      class Range < Step
        option :end_index,
               :register,
               :start_index

        def perform
          registers[register_option] = array(registers[register_option])

          registers[register_option] = registers[register_option][start_index..end_index]
        end

        private

        def start_index
          start_index_option.nil? ? 0 : start_index_option.to_i
        end

        def end_index
          end_index_option.nil? ? -1 : end_index_option.to_i
        end
      end
    end
  end
end
