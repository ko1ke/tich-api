FirebaseIdToken.configure do |config|
  config.project_ids = [ENV['FIREBASE_PROJECT_ID']]
  config.redis = Redis.new(url: ENV['REDIS_URL'] || 'redis://localhost:6379')
end
