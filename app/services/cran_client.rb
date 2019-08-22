class CranClient
  def initialize(url: 'https://cran.r-project.org/src/contrib/'.freeze)
    @conn = Faraday.new(url: url) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger if Rails.env.development?
      faraday.adapter Faraday.default_adapter
    end
  end

  def get(path, params = {})
    with_timeout_retry do
      @conn.get(path, params)
    end
  end

  private

  def with_timeout_retry(counter: 0, limit: 3)
    yield
  rescue Faraday::TimeoutError, Faraday::ConnectionFailed => error
    raise if (counter += 1) > limit

    Rails.logger.warn("#{counter} attempt fail due to #{error}")
    retry
  end
end
