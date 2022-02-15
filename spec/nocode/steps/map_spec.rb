# frozen_string_literal: true

require 'spec_helper'

describe Nocode::Steps::Map do
  subject(:step)     { described_class.new(options: options, context: context) }

  let(:io)           { StringIO.new }
  let(:context)      { Nocode::Context.new(registers: registers, io: io) }
  let(:registers)    { { 'a' => records } }

  let(:options) do
    {
      'register' => 'a',
      'steps' => [
        {
          'type' => 'record/map',
          'options' => {
            'key_mappings' => { 'THE_ID' => 'id', 'THE_NAME' => 'name' },
            'register' => '_element'
          }
        }
      ]
    }
  end

  let(:records) do
    [
      { 'id' => 1, 'name' => 'hops' },
      { 'id' => 2, 'name' => 'boo' }
    ]
  end

  it 'collects the iterator registers' do
    step.perform

    expected = [
      { 'THE_ID' => 1, 'THE_NAME' => 'hops' },
      { 'THE_ID' => 2, 'THE_NAME' => 'boo' }
    ]

    expect(context.register('a')).to eq(expected)
  end
end
