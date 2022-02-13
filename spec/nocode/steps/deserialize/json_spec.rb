# frozen_string_literal: true

require 'spec_helper'

describe Nocode::Steps::Deserialize::Json do
  subject(:step) { described_class.new(options: options, context: context) }

  let(:json) do
    <<~JSON
      [{"id":"1","name":"bozo"}]
    JSON
  end

  let(:registers) { { 'a' => json } }
  let(:context)   { Nocode::Context.new(registers: registers) }
  let(:options)   { { 'register' => 'a' } }

  it 'copies register value to another register' do
    step.perform

    expected = [
      { 'id' => '1', 'name' => 'bozo' }
    ]

    expect(context.register('a')).to eq(expected)
  end
end
