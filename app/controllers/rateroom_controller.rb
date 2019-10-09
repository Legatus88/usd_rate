class RateroomController < ApplicationController
  def index
    timer = Timer.last
    date = timer.nil? ? '' : timer.date

    unless timer.nil?
      @price = Time.current > timer.deadline ?  Timer.scrape : Timer.scrape(date)
    else
      @price = Timer.scrape
    end
  end
end
