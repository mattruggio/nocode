# frozen_string_literal: true

module Nocode
  class OptionsTemplate
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
