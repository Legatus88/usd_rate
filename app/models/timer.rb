class Timer < ApplicationRecord
  def self.scrape(date = '')
    require 'open-uri'
    date = "?date_req=#{date}" unless date == ''
    doc = Nokogiri::HTML(open("https://www.cbr.ru/currency_base/daily/#{date}"))
    rate = doc.css('table')[0].css('tr').select{|cell| cell.text.include? 'USD'}.first.css('td').last.text
  end
end
