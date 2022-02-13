# frozen_string_literal: true

require 'spec_helper'

describe Nocode::Steps::Set do
  subject(:step) { described_class.new(options: options, context: context) }

  let(:context)  { Nocode::Context.new }
  let(:options)  { { 'register' => 'a', 'value' => 'abc' } }

  it 'set register value' do
    step.perform

    expect(context.register('a')).to eq('abc')
  end
end
