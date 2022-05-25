module ResultFetcher
  class Both
    def fetch_results(query)
      google_results = ResultFetcher::Google.new.fetch_results(query)
      bing_results = ResultFetcher::Bing.new.fetch_results(query)
      interleave(google_results, bing_results).uniq(&:link)
    end

    private

    def interleave(google_results, bing_results)
      if google_results.length >= bing_results.length
        google_results.zip(bing_results)
      else
        bing_results.zip(google_results)
      end.flatten.compact
    end
  end
end
