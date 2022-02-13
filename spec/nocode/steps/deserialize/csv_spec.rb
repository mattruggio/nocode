# frozen_string_literal: true

require 'spec_helper'

describe Nocode::Steps::Deserialize::Csv do
  subject(:step)  { described_class.new(options: options, context: context) }

  let(:registers) { { 'a' => "id,name\n1,bozo\n" } }
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
