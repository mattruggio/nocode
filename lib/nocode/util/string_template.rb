# frozen_string_literal: true

module Nocode
  module Util
    # Takes in an expression and interpolates in any parameters using << >> notation.
    # For example:
    #   input = { 'person' => 'hops' }
    #   Nocode::Util::StringTemplate.new("Hello, << person.name >>!").evaluate(input)
    # Should produce: "Hello, hops!"
    class StringTemplate
      LEFT_TOKEN  = '<<'
      RIGHT_TOKEN = '>>'
      SEPARATOR   = '.'
      REG_EXPR    = /#{Regexp.quote(LEFT_TOKEN)}(.*?)#{Regexp.quote(RIGHT_TOKEN)}/.freeze

      attr_reader :expression

      def initialize(expression)
        @expression = expression.to_s

        freeze
      end

      def evaluate(values = {})
        resolved = tokens_to_values(tokens, values)

        tokens.inject(expression) do |memo, token|
          memo.gsub("#{LEFT_TOKEN}#{token}#{RIGHT_TOKEN}", resolved[token].to_s)
        end
      end

      private

      def tokens
        expression.to_s.scan(REG_EXPR).flatten
      end

      def tokens_to_values(tokens, values)
        tokens.each_with_object({}) do |token, memo|
          cleansed = token.strip
          parts    = cleansed.split(SEPARATOR)
          value    = values.dig(*parts)

          memo[token] = value
        end
      end
    end
  end
end
