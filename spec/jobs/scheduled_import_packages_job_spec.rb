require 'rails_helper'

describe ScheduledImportPackagesJob do
  describe '#perform' do
    it 'fetches packages and performs batch import' do
      packages = double
      batch_import_service = double(perform: true)
      expect(CranService).to receive_message_chain(:new, :packages).and_return(packages)
      expect(BatchImportPackagesService).to receive(:new).with(packages).and_return(batch_import_service)

      described_class.perform_now

      expect(batch_import_service).to have_received(:perform).once
    end
  end
end
