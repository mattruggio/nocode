# frozen_string_literal: true

module Nocode
  module Steps
    module Record
      # Create a new hash from an existing hash mapping each key as configured by the
      # key_mappings option.  The key_mappings option should be in the form of:
      #   new_key => old_key
      class Map < Step
        option :key_mappings, :register

        def perform
          input  = registers[register_option] || {}
          output = {}

          (key_mappings_option || {}).each do |to, from|
            output[to.to_s] = input[from.to_s]
          end

          registers[register_option] = output
        end
      end
    end
  end
end
