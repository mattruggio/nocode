# frozen_string_literal: true

require 'spec_helper'

describe Nocode::StepRegistry do
  subject(:registry) { described_class.instance }

  context 'when file is in the root steps folder' do
    it 'returns class constant' do
      expect(registry.constant!('sleep')).to eq(Nocode::Steps::Sleep)
    end
  end

  context 'when file is in a subfolder' do
    it 'returns class constant' do
      expect(registry.constant!('io/read')).to eq(Nocode::Steps::Io::Read)
    end
  end
end
