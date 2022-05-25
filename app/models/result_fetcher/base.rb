module ResultFetcher
  class Base
    def initialize(search_engine)
      @search_engine = search_engine
    end

    def fetch_results(query)
      raise ResultFetcher::MissingQuery unless query

      GoogleSearch.new(
        engine: @search_engine,
        q: query,
        api_key: ENV.fetch('SERPAPI_API_KEY')
      ).get_hash[:organic_results].map do |result_hash|
        Result.new title: result_hash[:title],
                   link: result_hash[:link],
                   snippet: result_hash[:snippet]
      end
    end
  end
end