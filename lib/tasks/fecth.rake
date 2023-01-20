namespace :fetch do
  desc 'fetch all the ticker and news'
  task sources: :environment do
    SpreadSheetFetchJob.perform_later
    FinnhubFetchJob.perform_later(limit_num: 1)
    FinnhubFetchJob.perform_later(limit_num: 9, klass_name: 'market')
    HackerNewsFetchJob.perform_later(limit_num: 1)
    RedditFetchJob.perform_later(limit_num: 1)
  end
end
