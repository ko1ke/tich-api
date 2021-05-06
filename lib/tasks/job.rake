namespace :job do
  desc 'Execute all the news fetch job'
  task fetch_news: :environment do
    SpreadSheetFetchJob.perform_later
    FinnhubFetchJob.perform_later(limit_num: 1)
    FinnhubFetchJob.perform_later(limit_num: 9, klass_name: 'market')
    HackerNewsFetchJob.perform_later(limit_num: 1)
    RedditFetchJob.perform_later(limit_num: 1)
  end
end
