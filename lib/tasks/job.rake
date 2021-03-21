namespace :job do
  desc 'Execute all the news fetch job'
  task fetch_news: :environment do
    FinnhubFetchJob.perform_later
    HackerNewsFetchJob.perform_later
    RedditFetchJob.perform_later
  end
end
