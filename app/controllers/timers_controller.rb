class TimersController < ApplicationController

  def new
    @timer = Timer.new
    @last_deadline = Timer.last.nil? ? Time.current : Timer.last.deadline
    @last_date     = Timer.last.nil? ? Time.current : Timer.last.date
  end

  def create
    timer = Timer.new(timer_params)
    if timer.save
      redirect_to root_path
      ActionCable.server.broadcast "rateroom_channel", rate: Timer.scrape(timer.date.strftime("%d.%m.%Y"))
    end
  end

  private

  def timer_params
    params.require(:timer).permit(:date, :deadline)
  end
end
