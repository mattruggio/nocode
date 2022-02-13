# frozen_string_literal: true

require 'spec_helper'

describe Nocode::Steps::Sleep do
  subject(:step) { described_class.new(options: options) }

  let(:seconds)  { 0.01 }
  let(:options)  { { 'seconds' => seconds } }

  it 'copies register value to another register' do
    allow(Kernel).to receive(:sleep)

    step.perform

    expect(Kernel).to have_received(:sleep).with(seconds)
  end
end
