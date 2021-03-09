class NyTimesSearchJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    q = 'election'
    connection = Faraday.new(url: 'https://api.nytimes.com')
    response = connection.get "/svc/search/v2/articlesearch.json?q=#{q}&api-key=#{ENV['NY_TIMES_KEY']}"

    p JSON.parse(response.body)
    byebug
    p 'end'
  end
end
