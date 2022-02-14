# frozen_string_literal: true

require 'spec_helper'

describe Nocode::Steps::Dataset::Coalesce do
  subject(:step)  { described_class.new(options: options, context: context) }

  let(:registers) do
    {
      'output' => 'existing',
      'a' => 'abc',
      'b' => %w[zzz yyy],
      'c' => { a: 1 }
    }
  end

  let(:context) { Nocode::Context.new(registers: registers) }
  let(:options) { { 'to_register' => 'output', 'from_registers' => %w[a b c] } }

  it 'takes all the values from the from_registers and combines them altogether' do
    step.perform

    expected = ['existing', 'abc', 'zzz', 'yyy', { a: 1 }]

    expect(context.register('output')).to eq(expected)
  end
end
