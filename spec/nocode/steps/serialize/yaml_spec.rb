# frozen_string_literal: true

require 'spec_helper'

describe Nocode::Steps::Serialize::Yaml do
  subject(:step)  { described_class.new(options: options, context: context) }

  let(:registers) { { 'a' => [{ 'id' => 1, 'name' => 'bozo' }] } }
  let(:context)   { Nocode::Context.new(registers: registers) }
  let(:options)   { { 'register' => 'a' } }

  it 'copies register value to another register' do
    step.perform

    expected = <<~YAML
      ---
      - id: 1
        name: bozo
    YAML

    expect(context.register('a')).to eq(expected)
  end
end
