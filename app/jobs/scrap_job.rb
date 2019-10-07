class ScrapJob < ApplicationJob
  self.queue_adapter = :sidekiq
  queue_as :default

  def perform(date = '')
    require 'open-uri'
    doc = Nokogiri::HTML(open("https://www.cbr.ru/currency_base/daily/#{date}"))
    price = "#{doc.css('table')[0].css('tr').select{|cell| cell.text.include? 'USD'}.first.css('td').last.text} + #{Time.now}}"

    ActionCable.server.broadcast "rateroom_channel", foo: price
  end
end
