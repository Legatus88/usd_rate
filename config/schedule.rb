set :output, "log/cron_log.log"
set :environment, 'development'

every 1.minute do
  runner "ScrapJob.perform_now"
end
