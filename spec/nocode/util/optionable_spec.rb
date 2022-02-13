# frozen_string_literal: true

require 'spec_helper'

class Animal
  include Nocode::Util::Optionable

  option :type

  def initialize(options)
    @options = options
  end
end

describe Nocode::Util::Optionable do
  subject(:animal) { Animal.new({ 'type' => 'dog' }) }

  describe '#method_missing' do
    it 'grabs the option value is defined' do
      expect(animal.type_option).to eq('dog')
    end
  end
end
