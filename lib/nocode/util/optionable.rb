# frozen_string_literal: true

module Nocode
  module Util
    module Optionable
      def self.included(klass)
        klass.extend(ClassMethods)
      end

      # Class-level DSL Methods
      module ClassMethods
        def option(*values)
          values.each { |v| options << v.to_s }
        end

        def options
          @options ||= []
        end
      end

      OPTION_PREFIX = '_option'

      def options
        @options || {}
      end

      def method_missing(name, *args, &block)
        key = option_key(name)

        if name.to_s.end_with?(OPTION_PREFIX) && self.class.options.include?(key)
          options[key]
        else
          super
        end
      end

      def respond_to_missing?(name, include_private = false)
        key = option_key(name)

        (name.to_s.end_with?(OPTION_PREFIX) && self.class.options.include?(key)) || super
      end

      private

      def option_key(name)
        name.to_s.gsub(OPTION_PREFIX, '')
      end
    end
  end
end
