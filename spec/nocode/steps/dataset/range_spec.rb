# frozen_string_literal: true

require 'spec_helper'

describe Nocode::Steps::Dataset::Range do
  subject(:step)  { described_class.new(options: options, context: context) }

  let(:registers) { { 'a' => [0, 1, 2, 3, 4, 5] } }
  let(:context)   { Nocode::Context.new(registers: registers) }
  let(:options)   { { 'register' => 'a', 'start_index' => 2, 'end_index' => 4 } }

  it 'preserves the elements from the start_index to end_index' do
    step.perform

    expected = [2, 3, 4]

    expect(context.register('a')).to eq(expected)
  end
end
