class ScrapJob < ApplicationJob
  self.queue_adapter = :sidekiq
  queue_as :default

  after_perform do |job|

  end

  def perform(date = '')
    require 'open-uri'
    doc = Nokogiri::HTML(open("https://www.cbr.ru/currency_base/daily/#{date}"))
    price = "#{doc.css('table')[0].css('tr').select{|cell| cell.text.include? 'USD'}.first.css('td').last.text} + #{rand(10)}"
    #price = doc.css('table')[0].css('tr').select{|cell| cell.text.include? 'USD'}.first.css('td').last.text
    #rate = Rate.new(price: price)
    #rate.save
    #p '111'*500
    #p rate
    #p rate.price
    ActionCable.server.broadcast "rateroom_channel", foo: price
  end
end
