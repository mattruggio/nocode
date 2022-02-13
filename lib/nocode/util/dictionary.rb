# frozen_string_literal: true

module Nocode
  module Util
    # A hash-like object which ensures all keys are strings.
    class Dictionary
      extend Forwardable

      NEWLINE_CHAR = "\n"

      class << self
        def ensure(value)
          if value.is_a?(self)
            value
          else
            new(value)
          end
        end
      end

      attr_reader :values

      def_delegators :values, :empty?

      def initialize(values = {})
        @values = {}

        (values || {}).each { |k, v| assign(k, v) }

        freeze
      end

      def delete(key)
        tap { values.delete(keyify(key)) }
      end

      def []=(key, value)
        tap { values[keyify(key)] = value }
      end

      def [](key)
        values[keyify(key)]
      end

      def dig(*keys)
        top_level = keyify(keys.first)
        keys = [top_level] + keys[1..]

        values.dig(*keys)
      end

      def key?(key)
        values.key?(keyify(key))
      end

      def to_s
        values.map { |k, v| "#{k}: #{v}" }.join(NEWLINE_CHAR)
      end

      private

      def assign(key, value)
        values[keyify(key)] = value
      end

      def keyify(value)
        value.to_s
      end
    end
  end
end
