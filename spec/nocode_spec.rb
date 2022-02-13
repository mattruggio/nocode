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

  describe 'csv_to_json.yaml' do
    let(:path) { File.join('spec', 'fixtures', 'csv_to_json.yaml') }

    it 'produces files' do
      described_class.execute(pathname, io: io)

      path = File.join('tmp', 'spec', 'people.json')

      expect(File.exist?(path)).to be true
    end

    it 'produces registers' do
      context   = described_class.execute(pathname, io: io)
      registers = context.registers

      json = <<~CONTENTS
        [{"id":"1","name":"bozo"},{"id":"2","name":"hops"}]
      CONTENTS

      expected = {
        '' => json.chomp
      }

      expect(registers.values).to eq(expected)
    end
  end

  describe 'json_to_csv.yaml' do
    let(:path) { File.join('spec', 'fixtures', 'json_to_csv.yaml') }

    it 'produces files' do
      described_class.execute(pathname, io: io)

      path = File.join('tmp', 'spec', 'people.csv')

      expect(File.exist?(path)).to be true
    end

    it 'produces registers' do
      context   = described_class.execute(pathname, io: io)
      registers = context.registers

      expected = {
        '' => "id,name\n1,bozo\n2,hops\n"
      }

      expect(registers.values).to eq(expected)
    end
  end
end
