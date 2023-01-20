Rails.application.configure do
  config.good_job.queues = '*'
  config.good_job.enable_cron = true
  config.good_job.execution_mode = :inline
end
