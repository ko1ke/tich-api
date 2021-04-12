namespace :job do
  desc 'Execute all the news fetch job'
  task fetch_news: :environment do
    FinnhubFetchJob.perform_later
    FinnhubFetchJob.perform_later(limit_num: 9, klass_name: 'market')
    HackerNewsFetchJob.perform_later
    RedditFetchJob.perform_later
  end
end
