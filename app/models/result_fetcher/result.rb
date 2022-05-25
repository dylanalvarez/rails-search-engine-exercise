module ResultFetcher
  class Result
    attr_reader :link

    def initialize(title:, link:, snippet:)
      @title = title
      @link = link
      @snippet = snippet
    end

    def as_json
      {
        title: @title,
        link: @link,
        snippet: @snippet,
      }
    end
  end
end