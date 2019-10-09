class TimersController < ApplicationController

  def new
    @timer = Timer.new
    @last_deadline = Timer.last.nil? ? Time.current : Timer.last.deadline
    @last_date     = Timer.last.nil? ? Time.current : Timer.last.date
  end

  def create
    @timer = Timer.new(timer_params)
    respond_to do |format|
      if @timer.save
        format.html { redirect_to root_path }
        format.json { render :show, status: :created, location: @timer }

        ActionCable.server.broadcast "rateroom_channel", rate: Timer.scrape(@timer.date.strftime("%d.%m.%Y"))
      else
        format.html { render :new }
        format.json { render json: @timer.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def timer_params
    params.require(:timer).permit(:date, :deadline)
  end
end
