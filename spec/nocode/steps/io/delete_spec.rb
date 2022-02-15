# frozen_string_literal: true

require 'spec_helper'

describe Nocode::Steps::Io::Delete do
  subject(:step)  { described_class.new(options: options, context: context) }

  let(:registers) { {} }
  let(:context)   { Nocode::Context.new(registers: registers) }
  let(:options)   { { 'register' => 'a', 'path' => dest_path } }
  let(:dest_path) { File.join('tmp', 'delete_me.csv') }

  it 'deletes specified paths' do
    FileUtils.mkdir_p('tmp')

    FileUtils.cp(
      File.join('spec', 'fixtures', 'people.csv'),
      dest_path
    )

    step.perform

    expect(File.exist?(dest_path)).to be false
  end
end
