module ResultFetcher
  class Both
    def fetch_results(query)
      google_results = ResultFetcher::Google.new.fetch_results(query)
      bing_results = ResultFetcher::Bing.new.fetch_results(query)
      (google_results.zip(bing_results).flatten + bing_results.zip(google_results).flatten).compact.uniq(&:link)
    end
  end
end
