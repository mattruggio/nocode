# frozen_string_literal: true

require 'spec_helper'

describe Nocode::Util::StringTemplate do
  subject(:template) { described_class.new(expression) }

  describe '#evaluate' do
    context 'when expression has nested param' do
      let(:expression) { 'a b c << d.e >> g h' }

      it 'renders with nested value' do
        values = { 'd' => { 'e' => 'f' } }
        actual = template.evaluate(values)

        expect(actual).to eq('a b c f g h')
      end
    end

    context 'when expression has top-level param' do
      let(:expression) { 'a b c << d >> g h' }

      it 'renders with single value' do
        values = { 'd' => 'e' }
        actual = template.evaluate(values)

        expect(actual).to eq('a b c e g h')
      end
    end
  end
end
