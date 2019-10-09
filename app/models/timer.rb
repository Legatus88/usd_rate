class Timer < ApplicationRecord
  validate :date_validate
  validate :deadline_validate

  def self.scrape(date = '')
    require 'open-uri'
    date = "?date_req=#{date}" unless date == ''
    doc = Nokogiri::HTML(open("https://www.cbr.ru/currency_base/daily/#{date}"))
    doc.css('table')[0].css('tr').select{|cell| cell.text.include? 'USD'}.first.css('td').last.text
  end

  def date_validate
    errors.add(:date, 'is invalid') if self.date >= Date.today
  end

  def deadline_validate
    errors.add(:deadline, 'is invalid') if self.deadline < Time.current
  end
end
