namespace :elastic_search do
  desc 'import records to elastic search'
  task import: :environment do
    if Flipper.enabled? :elastic_search
      News.create_index! unless News.index_exist?
      News.import
    end
  end
end
