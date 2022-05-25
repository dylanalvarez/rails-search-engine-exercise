class SearchController < ApplicationController
  def search
    result_fetcher = ResultFetcher.by_search_engine(params[:search_engine])
    render json: result_fetcher.fetch_results(params[:query]).map(&:as_json)
  rescue ResultFetcher::InvalidSearchEngine => e
    render status: :bad_request, json: { error: "Invalid 'search_engine' parameter: '#{e.search_engine}'" }
  rescue ResultFetcher::MissingQuery
    render status: :bad_request, json: { error: "Missing 'query' parameter" }
  rescue StandardError
    render status: :internal_server_error, json: { error: 'Internal server error' }
  end
end
