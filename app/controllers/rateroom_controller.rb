class RateroomController < ApplicationController
  def index
    @price = scrape
    ScrapJob.perform_now
  end

  def admin
  end

  def force_rate
    @date = "?date_req=17.02.2011"
    scrape
  end

  private

  def scrape
    require 'open-uri'
    doc = Nokogiri::HTML(open("https://www.cbr.ru/currency_base/daily/#{@date}"))
    "#{doc.css('table')[0].css('tr').select{|cell| cell.text.include? 'USD'}.first.css('td').last.text} + #{Time.now}"
  end
end
