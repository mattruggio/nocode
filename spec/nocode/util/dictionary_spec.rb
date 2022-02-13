# frozen_string_literal: true

require 'spec_helper'

describe Nocode::Util::Dictionary do
  subject(:dictionary) { described_class.new }

  describe 'Dictionary#ensure' do
    it 'returns a Dictionary instance if a hash is passed in' do
      input = { a: '1' }

      actual = described_class.ensure(input)

      expect(actual).to be_a(described_class)
    end

    it 'returns if a Dictionary instance is passed in' do
      input = described_class.new

      actual = described_class.ensure(input)

      expect(actual).to equal(input)
    end
  end

  describe '#[] and #[]=' do
    it 'symbol keys work as string keys' do
      key             = :abc
      value           = :def
      dictionary[key] = value

      expect(dictionary[key.to_s]).to eq(value)
    end
  end

  describe '#delete' do
    it 'removes the key' do
      key             = :abc
      dictionary[key] = '123'

      dictionary.delete(key)

      expect(dictionary.key?(key)).to be false
    end
  end

  describe '#dig' do
    it 'works with symbol top-level key' do
      key_value = 'abc'
      key1      = :key1
      key2      = :key2

      value = {
        key2 => 'abc'
      }

      dictionary[key1] = value

      expect(dictionary.dig(key1, key2)).to eq(key_value)
    end
  end

  describe '#to_s' do
    let(:key1)   { 'key1' }
    let(:value1) { 'value1' }

    before { dictionary[key1] = value1 }

    it 'prints out key: value' do
      actual = dictionary.to_s

      expect(actual).to include("#{key1}: #{value1}")
    end
  end
end
