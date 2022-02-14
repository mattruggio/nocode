# frozen_string_literal: true

require 'spec_helper'

describe Nocode::Steps::Dataset::Append do
  subject(:step)  { described_class.new(options: options, context: context) }

  let(:registers) { { 'a' => 'abc' } }
  let(:context)   { Nocode::Context.new(registers: registers) }
  let(:options)   { { 'register' => 'a', 'entries' => %w[a b c] } }

  it 'takes all the values from the from_registers and combines them altogether' do
    step.perform

    expected = %w[abc a b c]

    expect(context.register('a')).to eq(expected)
  end
end
