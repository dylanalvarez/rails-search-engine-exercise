module ResultFetcher
  ENGINE_CLASS_BY_NAME = {
    'google' => ResultFetcher::Google,
    'bing' => ResultFetcher::Bing,
    'both' => ResultFetcher::Both
  }.freeze

  def self.by_search_engine(search_engine)
    klass = ENGINE_CLASS_BY_NAME[search_engine]

    raise InvalidSearchEngine, search_engine unless klass

    klass.new
  end
end
