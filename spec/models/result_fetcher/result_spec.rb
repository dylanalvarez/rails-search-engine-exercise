require 'rails_helper'

describe ResultFetcher::Result do
  it 'passes constructor parameters to its serialized form' do
    expect(
      described_class.new(
        title: 365,
        link: 'https://www.google.com/',
        snippet: nil
      ).as_json
    ).to(
      eq(
        title: 365,
        link: 'https://www.google.com/',
        snippet: nil
      )
    )
  end

  it 'makes link accessible through method' do
    expect(
      described_class.new(
        title: 'Google',
        link: 'https://www.google.com/',
        snippet: 'Most popular search engine'
      ).link
    ).to(
      eq('https://www.google.com/')
    )
  end
end
