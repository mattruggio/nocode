# frozen_string_literal: true

require 'spec_helper'

describe Nocode::Steps::Log do
  subject(:step) { described_class.new(options: options, context: context) }

  let(:context)  { Nocode::Context.new(io: io) }
  let(:io)       { StringIO.new }
  let(:options)  { { 'message' => 'Hello World!' } }

  it 'prints message to io' do
    step.perform

    expect(io.string).to include('Hello World!')
  end
end
