FirebaseIdToken.configure do |config|
  config.project_ids = ['tich-de99a']
  config.redis = Redis.new(url: ENV['REDIS_URL'] || 'redis://localhost:6379')
end
