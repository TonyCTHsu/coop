require 'rails_helper'

describe UpdatePackageDetailService do
  describe '#perform' do
    it do
      package_version = PackageVersion.create(name: 'A', version: '1.0.0')
      cran_service = double(description: Cran::Description.new(
        'Title' => 'title',
        'Description' => 'description',
        'Date/Publication' => 'published_at',
        'Maintainer' => 'maintainer',
        'Author' => 'authors'
      ))
      expect(CranService).to receive(:new).and_return(cran_service)
      expect(CreatePackageAuthorshipsJob).to receive(:perform_later).with(package_version).once

      service = described_class.new(package_version)

      expect do
        service.perform
      end.to change { package_version.reload.title }.from(nil).to('title')
      expect(cran_service).to have_received(:description).with(package_version)
    end
  end
end
