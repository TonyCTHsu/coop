require 'rails_helper'

describe ImportPackagesService do
  describe '#perform' do
    it 'imports packages and enqueue callback job' do
      allow(ImportPackagesCallbackJob).to receive(:perform_later)
      packages = [
        { name: 'A3', version: '1.0.0'},
        { name: 'aaSEA', version: '1.0.0'},
        { name: 'abbyyR', version: '0.5.5'}
      ]

      expect do
        described_class.new(packages).perform
      end.to change { PackageVersion.count }.from(0).to(3)
      expect(ImportPackagesCallbackJob).to have_received(:perform_later).with(a_collection_length_of(3))

      expect do
        described_class.new(packages).perform
      end.not_to change { PackageVersion.count }
      expect(ImportPackagesCallbackJob).to have_received(:perform_later).with(a_collection_length_of(0))
    end
  end
end
