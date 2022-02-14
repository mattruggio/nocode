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

    it 'defaults to normal implementation if not an option' do
      expect { animal.non_existant_option }.to raise_error(NoMethodError)
    end
  end

  describe '#respond_to_missing?' do
    it 'returns true for valid options' do
      expect(animal.send(:respond_to_missing?, :type_option)).to be true
    end

    it 'returns false for invalid options' do
      expect(animal.send(:respond_to_missing?, :non_existant_option)).to be false
    end
  end
end
