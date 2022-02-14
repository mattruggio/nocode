# frozen_string_literal: true

require 'spec_helper'

describe Nocode::Steps::Dataset::Insert do
  subject(:step)  { described_class.new(options: options, context: context) }

  let(:registers) { { 'a' => [0, 1, 2, 3, 4, 5] } }
  let(:context)   { Nocode::Context.new(registers: registers) }
  let(:options)   { { 'register' => 'a', 'entries' => %w[a b c], 'at_index' => 2 } }

  it 'takes all the values from the from_registers and combines them altogether' do
    step.perform

    expected = [0, 1, 'a', 'b', 'c', 2, 3, 4, 5]

    expect(context.register('a')).to eq(expected)
  end
end
