require 'rails_helper'

describe Cran::Package do
  describe '#to_h' do
    it 'returns a hash with name and version' do
      cran_package = described_class.new('Package' => 'A3', 'Version' => '1.0.0')

      expect(cran_package.to_h).to eq(
        name: 'A3',
        version: '1.0.0'
      )
    end

    context 'when package name is not provided' do
      it do
        expect { described_class.new('Version' => '1.0.0').to_h }.to raise_error(KeyError, /Package/)
      end
    end

    context 'when version is not provided' do
      it do
        expect { described_class.new('Package' => 'A3').to_h }.to raise_error(KeyError, /Version/)
      end
    end
  end
end
