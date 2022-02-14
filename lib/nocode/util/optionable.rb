# frozen_string_literal: true

module Nocode
  module Util
    # Add on a DSL for classes.  The DSL allows for a new class-level keyword called 'option'
    # which can be used to describe what metadata values are important.  Then instances
    # can reference those option's values using magic _option methods.  For example:
    #
    # class Animal
    #   include Optionable
    #   option :type
    #   attr_writer :options
    # end
    #
    # animal = Animal.new
    # animal.options = { 'type' => 'dog' }
    #
    # animal.type_option # -> should return 'dog'
    module Optionable
      def self.included(klass)
        klass.extend(ClassMethods)
      end

      # Class-level DSL Methods
      module ClassMethods
        def skip_options_evaluation?
          @skip_options_evaluation || false
        end

        def skip_options_evaluation!
          @skip_options_evaluation = true
        end

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
