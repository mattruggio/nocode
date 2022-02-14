# frozen_string_literal: true

module Nocode
  module Steps
    module Serialize
      # Take the contents of a register and create a CSV out of its contents.  The CSV contents
      # will override the register specified.
      class Csv < Step
        option :register

        def perform
          input = registers[register_option]

          registers[register_option] = CSV.generate do |csv|
            array(input).each_with_index do |object, index|
              csv << object.keys if index.zero? && object.respond_to?(:keys)

              add_object(object, csv)
            end
          end
        end

        private

        def add_object(object, csv)
          object ||= {}

          if object.is_a?(Array)
            csv << object
          elsif object.respond_to?(:values)
            csv << object.values
          end
        end
      end
    end
  end
end
