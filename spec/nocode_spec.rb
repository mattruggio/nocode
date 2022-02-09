# frozen_string_literal: true

require 'spec_helper'

describe Nocode do
  specify 'Nocode module is recognized' do
    expect { described_class }.not_to raise_error
  end
end
