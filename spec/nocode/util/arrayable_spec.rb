# frozen_string_literal: true

require 'spec_helper'

class Widget
  include Nocode::Util::Arrayable
end

describe Nocode::Util::Arrayable do
  subject(:widget) { Widget.new }

  describe '#array' do
    context 'when hash' do
      let(:value) { { a: 1 } }

      it 'returns array' do
        actual = widget.array(value)

        expect(actual).to eq([value])
      end
    end

    context 'when array' do
      let(:value) { [:a] }

      it 'returns array' do
        actual = widget.array(value)

        expect(actual).to eq(value)
      end
    end

    context 'when string' do
      let(:value) { 'a' }

      it 'returns array' do
        actual = widget.array(value)

        expect(actual).to eq([value])
      end
    end
  end
end
