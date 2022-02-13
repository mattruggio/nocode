# frozen_string_literal: true

require 'spec_helper'

describe Nocode do
  let(:io)       { StringIO.new }
  let(:pathname) { Pathname.new(path) }

  describe 'example.yaml' do
    let(:path) { File.join('spec', 'fixtures', 'example.yaml') }

    it 'produces files' do
      described_class.execute(pathname, io: io)

      path = File.join('tmp', 'spec', 'message.txt')

      expect(File.exist?(path)).to be true
    end

    it 'produces registers' do
      context   = described_class.execute(pathname, io: io)
      registers = context.registers

      expected = {
        'message_copy' => 'Hello, Hops The Bunny!',
        'other_message' => 'Hello, Hops The Bunny!'
      }

      expect(registers.values).to eq(expected)
    end
  end
end
