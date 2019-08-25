require 'rails_helper'

describe CreatePackageAuthorshipsJob do
  describe '#perform' do
    it do
      package = double
      service = double(perform: true)
      expect(CreatePackageAuthorshipsService).to receive(:new).and_return(service)

      described_class.perform_now(package)

      expect(service).to have_received(:perform).once
    end
  end
end
