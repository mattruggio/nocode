# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable Lint/EmptyClass
class Abc; end
class Def; end
# rubocop:enable Lint/EmptyClass

describe Nocode::Steps::Copy do
  subject(:step)  { described_class.new(options: options, context: context) }

  let(:registers) { { 'a' => 'abc' } }
  let(:context)   { Nocode::Context.new(registers: registers) }
  let(:options)   { { 'to_register' => 'b', 'from_register' => 'a' } }

  it 'copies register value to another register' do
    step.perform

    expect(context.register('b')).to eq('abc')
  end
end
