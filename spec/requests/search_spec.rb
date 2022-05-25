require 'rails_helper'

RSpec.describe "Search", type: :request do
  describe "GET /search" do
    it "responds with bad request when query is missing" do
      get "/search?search_engine=google"
      expect(response.status).to(eq(400))
      expect(response.body).to(eq({ error: "Missing 'query' parameter" }.to_json))
    end

    it "responds with bad request when search_engine is missing" do
      get "/search?search_engine=invalid_engine&query=hello"
      expect(response.status).to(eq(400))
      expect(response.body).to(eq({ error: "Invalid 'search_engine' parameter: 'invalid_engine'" }.to_json))
    end

    it "responds with bad request when search_engine is not supported" do
      get "/search?query=hello"
      expect(response.status).to(eq(400))
      expect(response.body).to(eq({ error: "Invalid 'search_engine' parameter: ''" }.to_json))
    end

    it "responds with internal server error when serpapi request doesn't return expected response" do
      stub_request(
        :get,
        "https://serpapi.com/search?api_key=#{ENV.fetch('SERPAPI_API_KEY')}&engine=google&output=json&q=hello&source=ruby"
      ).to_return(
        status: 400,
      )
      get "/search?search_engine=google&query=hello"
      expect(response.status).to(eq(500))
      expect(response.body).to(eq({ error: 'Internal server error' }.to_json))
    end

    it "responds successfully when serpapi request returns correct response" do
      results = [{
        "title": "Google 1",
        "link": "https://www.url1.com/",
        "snippet": "Google 1 snippet",
      }]
      stub_request(
        :get,
        "https://serpapi.com/search?api_key=#{ENV.fetch('SERPAPI_API_KEY')}&engine=google&output=json&q=hello&source=ruby"
      ).to_return(
        status: 200,
        body: { organic_results: results }.to_json
      )
      get "/search?search_engine=google&query=hello"
      expect(response.status).to(eq(200))
      expect(response.body).to(eq(results.to_json))
    end
  end
end
