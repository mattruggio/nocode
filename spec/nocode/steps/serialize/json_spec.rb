# frozen_string_literal: true

require 'spec_helper'

describe Nocode::Steps::Serialize::Json do
  subject(:step)  { described_class.new(options: options, context: context) }

  let(:registers) { { 'a' => [{ 'id' => '1', 'name' => 'bozo' }] } }
  let(:context)   { Nocode::Context.new(registers: registers) }
  let(:options)   { { 'register' => 'a' } }

  it 'copies register value to another register' do
    step.perform

    expected = <<~JSON
      [{"id":"1","name":"bozo"}]
    JSON

    expect(context.register('a')).to eq(expected.chomp)
  end
end
