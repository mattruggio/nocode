# frozen_string_literal: true

require 'spec_helper'

describe Nocode::Steps::Deserialize::Yaml do
  subject(:step) { described_class.new(options: options, context: context) }

  let(:yaml) do
    <<~YAML
      ---
      - id: 1
        name: bozo
    YAML
  end

  let(:registers) { { 'a' => yaml } }
  let(:context)   { Nocode::Context.new(registers: registers) }
  let(:options)   { { 'register' => 'a' } }

  it 'copies register value to another register' do
    step.perform

    expected = [
      { 'id' => 1, 'name' => 'bozo' }
    ]

    expect(context.register('a')).to eq(expected)
  end
end
