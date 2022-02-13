# frozen_string_literal: true

require 'spec_helper'

describe Nocode::Context do
  subject(:context) do
    described_class.new(
      registers: { key => value },
      parameters: { key2 => value2 }
    )
  end

  let(:key) { :a }
  let(:value) { 123 }

  let(:key2) { :b }
  let(:value2) { 456 }

  specify '#register returns a register value' do
    actual = context.register(key)

    expect(actual).to eq(value)
  end

  specify '#parameter returns a register value' do
    actual = context.parameter(key2)

    expect(actual).to eq(value2)
  end
end
