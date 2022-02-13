# frozen_string_literal: true

require_relative 'string_template'

module Nocode
  module Util
    # Built on top of StringTemplate but instead of only working for a string, this will
    # recursively evaluate all strings within an object.  Heuristics:
    #    - Strings evaluate using StringTemplate
    #    - Hashes will have their keys and values traversed
    #    - Arrays will have their entries traversed
    #    - All other types will simply return themselves
    class ObjectTemplate
      attr_reader :object

      def initialize(object)
        @object = object

        freeze
      end

      def evaluate(values = {})
        recursive_evaluate(object, values)
      end

      private

      def recursive_evaluate(expression, values)
        case expression
        when Array
          expression.map { |o| recursive_evaluate(o, values) }
        when Hash
          expression.to_h do |k, v|
            [recursive_evaluate(k, values), recursive_evaluate(v, values)]
          end
        when String
          Util::StringTemplate.new(expression).evaluate(values)
        else
          expression
        end
      end
    end
  end
end
