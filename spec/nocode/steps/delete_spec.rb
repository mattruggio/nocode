# frozen_string_literal: true

require 'spec_helper'

describe Nocode::Steps::Delete do
  subject(:step)  { described_class.new(options: options, context: context) }

  let(:context)   { Nocode::Context.new(registers: registers) }
  let(:registers) { { 'a' => 'abc' } }
  let(:options)   { { 'register' => 'a' } }

  it 'copies register value to another register' do
    step.perform

    expect(context.registers).to be_empty
  end
end
