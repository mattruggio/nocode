# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable Lint/EmptyClass
class Abc; end
class Def; end
# rubocop:enable Lint/EmptyClass

describe Nocode::Util::ClassRegistry do
  subject(:registry) { described_class.new(mappings) }

  let(:mappings) { { 'a' => 'Abc' } }

  describe '#unregister' do
    it 'removes type' do
      registry.unregister('a')

      error_class = Nocode::Util::ClassRegistry::NotRegisteredError

      expect { registry.constant!('a') }.to raise_error(error_class)
    end
  end

  describe '#constant!' do
    context 'when type is registered' do
      it 'gets back class registered through #initialize' do
        expect(registry.constant!('a')).to eq(Abc)
      end

      it 'gets back class registered through #register' do
        registry.register('b', 'Def')

        expect(registry.constant!('b')).to eq(Def)
      end
    end

    context 'when type is registered but is not defined' do
      it 'raises NameError' do
        registry.register('d', 'IDontExist')

        expect { registry.constant!('d') }.to raise_error(NameError)
      end
    end

    context 'when type is not registered' do
      it 'raises ClassNotRegisteredError' do
        error_class = Nocode::Util::ClassRegistry::NotRegisteredError

        expect { registry.constant!('zzz') }.to raise_error(error_class)
      end
    end
  end
end
