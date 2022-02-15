# frozen_string_literal: true

require 'spec_helper'

describe Nocode::Steps::Record::Map do
  subject(:step)     { described_class.new(options: options, context: context) }

  let(:registers)    { { 'a' => { 'id' => 1, 'name' => 'bozo' } } }
  let(:context)      { Nocode::Context.new(registers: registers) }
  let(:options)      { { 'register' => 'a', 'key_mappings' => key_mappings } }
  let(:key_mappings) { { 'new_id' => 'id' } }

  it 'produces newly mapped hash' do
    step.perform

    expected = { 'new_id' => 1 }

    expect(context.register('a')).to eq(expected)
  end
end
