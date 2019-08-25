require 'rails_helper'

describe BatchImportPackagesService do
  describe '#perform' do
    it 'imports packages in batches' do
      import_service = double(perform: true)
      packages = [
        Cran::Package.new('Package' => 'A3', 'Version' => '1.0.0'),
        Cran::Package.new('Package' => 'aaSEA', 'Version' => '1.0.0'),
        Cran::Package.new('Package' => 'abbyyR', 'Version' => '0.5.5')
      ]
      expect(ImportPackagesService).to receive(:new).and_return(import_service).twice

      described_class.new(packages).perform(batch_size: 2)
    end
  end
end
