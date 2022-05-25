require 'rails_helper'

describe ResultFetcher do
  def stub_serpapi_request(engine, organic_results)
    stub_request(
      :get,
      "https://serpapi.com/search?api_key=#{ENV.fetch('SERPAPI_API_KEY')}&engine=#{engine}&output=json&q=ruby%20on%20rails&source=ruby"
    ).to_return(
      status: 200,
      body: {
        organic_results: organic_results
      }.to_json
    )
  end

  context 'when search engine is invalid' do
    it 'throws an error on instantiation' do
      search_engine = 'sarasa'
      expect do
        described_class.by_search_engine(search_engine)
      end.to(raise_error(ResultFetcher::InvalidSearchEngine, "Invalid search engine: #{search_engine}"))
    end
  end

  context 'when search engine is valid' do
    it 'throws an error when the query is missing' do
      result_fetcher = described_class.by_search_engine('google')
      expect do
        result_fetcher.fetch_results(nil)
      end.to(raise_error(ResultFetcher::MissingQuery))
    end

    it 'performs a request and parses its result' do
      result_fetcher = described_class.by_search_engine('google')

      organic_results = [
        {
          "title": "Ruby on Rails — A web-app framework that includes ...",
          "link": "https://rubyonrails.org/",
          "snippet": "Rails is a full-stack framework. It ships with all the tools needed to build amazing web apps on both the front and back end. Rendering HTML templates, updating ...",
        },
        {
          "title": "Ruby on Rails - Wikipedia",
          "link": "https://en.wikipedia.org/wiki/Ruby_on_Rails",
          "snippet": "Ruby on Rails, or Rails, is a server-side web application framework written in Ruby under the MIT License. Rails is a model–view–controller (MVC) framework, ...",
        },
      ]

      stub_serpapi_request('google', organic_results)

      results = result_fetcher.fetch_results('ruby on rails')
      expect(results.map(&:as_json)).to(eq(organic_results))
    end
  end

  context 'when search engine is both' do
    it 'performs google and bing requests and interleaves its result, removing duplicate urls' do
      result_fetcher = described_class.by_search_engine('both')

      google_1_result = {
        "title": "Google 1",
        "link": "https://www.url1.com/",
        "snippet": "Google 1 snippet",
      }
      google_2_result = {
        "title": "Google 2",
        "link": "https://www.url2.com/",
        "snippet": "Google 2 snippet",
      }
      google_organic_results = [
        google_1_result,
        google_2_result
      ]

      bing_1_result = {
        "title": "Bing 1",
        "link": "https://www.url3.com/",
        "snippet": "Bing 1 snippet",
      }
      bing_2_result = {
        "title": "Bing 2",
        "link": "https://www.url1.com/",
        "snippet": "Bing 2 snippet",
      }
      bing_3_result = {
        "title": "Bing 3",
        "link": "https://www.url4.com/",
        "snippet": "Bing 3 snippet",
      }
      bing_4_result = {
        "title": "Bing 4",
        "link": "https://www.url5.com/",
        "snippet": "Bing 4 snippet",
      }
      bing_organic_results = [
        bing_1_result,
        bing_2_result,
        bing_3_result,
        bing_4_result
      ]

      stub_serpapi_request('google', google_organic_results)
      stub_serpapi_request('bing', bing_organic_results)

      results = result_fetcher.fetch_results('ruby on rails')
      expect(results.map(&:as_json)).to(
        eq(
          [
            bing_1_result, google_1_result, google_2_result, bing_3_result, bing_4_result
          ]
        )
      )
    end
  end
end
