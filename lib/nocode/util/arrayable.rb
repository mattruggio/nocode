# frozen_string_literal: true

module Nocode
  module Util
    module Arrayable
      def array(value)
        if value.is_a?(Hash)
          [value]
        else
          Array(value)
        end
      end
    end
  end
end
