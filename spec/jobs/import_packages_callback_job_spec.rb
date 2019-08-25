require 'rails_helper'

describe ImportPackagesCallbackJob do
  describe '#perform' do
    it do
      allow(UpdatePackageDetailJob).to receive(:perform_later)
      packages = [
        PackageVersion.create(name: 'A', version: '1.0.0'),
        PackageVersion.create(name: 'B', version: '2.0.0')
      ]

      described_class.perform_now(packages.map(&:id))

      expect(UpdatePackageDetailJob).to have_received(:perform_later).exactly(packages.length).times
    end
  end
end
