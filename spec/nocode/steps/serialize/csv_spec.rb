# frozen_string_literal: true

require 'spec_helper'

describe Nocode::Steps::Serialize::Csv do
  subject(:step)  { described_class.new(options: options, context: context) }

  let(:registers) { { 'a' => [{ 'id' => '1', 'name' => 'bozo' }] } }
  let(:context)   { Nocode::Context.new(registers: registers) }
  let(:options)   { { 'register' => 'a' } }

  it 'serializes register contents as CSV' do
    step.perform

    expected = "id,name\n1,bozo\n"

    expect(context.register('a')).to eq(expected)
  end

  context 'when contents is an array of arrays' do
    let(:registers) do
      {
        'a' => [
          %w[id name],
          %w[1 bozo]
        ]
      }
    end

    it 'serializes register contents as CSV' do
      step.perform

      expected = "id,name\n1,bozo\n"

      expect(context.register('a')).to eq(expected)
    end
  end
end
