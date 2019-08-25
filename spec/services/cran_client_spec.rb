require 'rails_helper'

describe CranClient do
  describe '#get' do
    it 'sends a GET request with params and returns a response' do
      stub_request(:get, /cran.r-project.org/).and_return(status: 200, body: 'body')
      client = described_class.new

      result = client.get('path')

      expect(result.status).to eq(200)
      expect(result.body).to eq('body')
      expect(WebMock).to have_requested(:get, 'https://cran.r-project.org/src/contrib/path')
    end

    it 'retries when timeout' do
      stub_request(:get, /cran.r-project.org/).to_timeout.then.to_return(status: 200)
      client = described_class.new

      result = client.get('path')

      expect(result.status).to eq(200)
      expect(WebMock).to have_requested(:get, 'https://cran.r-project.org/src/contrib/path').twice
    end

    it 'raises error after 3 retries' do
      stub_request(:get, /cran.r-project.org/).to_timeout
      client = described_class.new

      expect do
        client.get('path')
      end.to raise_error Faraday::ConnectionFailed

      expect(WebMock).to have_requested(:get, 'https://cran.r-project.org/src/contrib/path').times(4)
    end
  end
end
