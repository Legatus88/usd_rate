class ScrapJob < ApplicationJob
  self.queue_adapter = :sidekiq
  queue_as :default

  def perform(date = '')
    return if delayed?
    rate = Timer.scrape
    ActionCable.server.broadcast "rateroom_channel", rate: rate
  end

  def delayed?
    return false if Timer.last.nil?
    Time.now < Timer.last.deadline
  end
end
