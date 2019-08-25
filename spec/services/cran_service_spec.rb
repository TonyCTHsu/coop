require 'rails_helper'

describe CranService do
  describe '#packages' do
    it 'returns an array of cran packages' do
      text = <<-HEREDOC
Package: A3
Version: 1.0.0

Package: aaSEA
Version: 1.0.0
      HEREDOC
      client = double(get: Faraday::Response.new(body: text))
      allow(Cran::Package).to receive(:new).and_call_original

      service = described_class.new(client)

      result = service.packages

      expect(result.size).to eq(2)
      expect(result).to all be_a_kind_of Cran::Package
      expect(client).to have_received(:get).with('PACKAGES').once
      expect(Cran::Package).to have_received(:new).with('Package' => 'A3', 'Version' => '1.0.0')
      expect(Cran::Package).to have_received(:new).with('Package' => 'aaSEA', 'Version' => '1.0.0')
    end
  end

  describe '#description' do
    it do
      text = File.read('spec/file_fixtures/A3_1.0.0.tar.gz')
      client = double(get: Faraday::Response.new(body: text))
      package = double(path: 'A3_1.0.0')

      result = described_class.new(client).description(package)

      expect(result).to be_a(Cran::Description)
      expect(result.to_h).to include(
        maintainer_string: 'Scott Fortmann-Roe <scottfr@berkeley.edu>'
      )
      expect(client).to have_received(:get).with('A3_1.0.0.tar.gz').once
    end
  end
end

