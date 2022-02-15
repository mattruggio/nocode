# frozen_string_literal: true

require 'spec_helper'

describe Nocode::Steps::Io::List do
  subject(:step)  { described_class.new(options: options, context: context) }

  let(:registers) { {} }
  let(:context)   { Nocode::Context.new(registers: registers) }
  let(:options)   { { 'register' => 'a', 'path' => %w[spec fixtures input *.csv] } }

  it 'loads register with list of files' do
    step.perform

    expected = [
      'spec/fixtures/input/people2.csv',
      'spec/fixtures/input/people1.csv'
    ]

    expect(context.register('a')).to match_array(expected)
  end
end
