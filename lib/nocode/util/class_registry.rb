# frozen_string_literal: true

module Nocode
  module Util
    class ClassRegistry
      extend Forwardable

      class NotRegisteredError < StandardError; end

      attr_reader :types_to_classes

      def_delegators :types_to_classes, :to_s

      def initialize(types_to_classes = {})
        @types_to_classes = Dictionary.new(types_to_classes)

        freeze
      end

      def load(types, prefix = '')
        types.each do |type|
          pascal_cased = type.split(File::SEPARATOR).map do |part|
            part.split('_').collect(&:capitalize).join
          end.join('::')

          register(type, "#{prefix}#{pascal_cased}")
        end

        self
      end

      def register(type, class_name)
        tap { types_to_classes[type] = class_name }
      end

      def unregister(type)
        tap { types_to_classes.delete(type) }
      end

      def constant!(type)
        name = types_to_classes[type]

        raise NotRegisteredError, "Constant not registered for: #{type}" if name.to_s.empty?

        if Object.const_defined?(name, false)
          Object.const_get(name, false)
        else
          Object.const_missing(name)
        end
      end
    end
  end
end
