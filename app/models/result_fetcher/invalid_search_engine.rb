module ResultFetcher
  class InvalidSearchEngine < StandardError
    def initialize(search_engine)
      @search_engine = search_engine
      super("Invalid search engine: #{search_engine}")
    end

    attr_reader :search_engine
  end
end
