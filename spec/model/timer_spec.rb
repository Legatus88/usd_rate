require 'rails_helper'

RSpec.describe Timer, :type => :model do

  it "is valid with valid attributes" do
    timer = Timer.new(date: Date.today - 1.day, deadline: Time.current + 3.minute)
    expect(timer).to be_valid
  end

  it "is not valid without a date" do
    timer = Timer.new(deadline: Time.current + 2.hour)
    expect(timer).to_not be_valid
  end

  it "is not valid without a deadline" do
    timer = Timer.new(date: Date.today - 1.day)
    expect(timer).to_not be_valid
  end

  it "is not valid with invalid date" do
    timer1 = Timer.new(date: Date.today, deadline: Time.current + 2.hour)
    timer2 = Timer.new(date: Date.today + 1.day, deadline: Time.current + 2.hour)
    expect(timer1).to_not be_valid
    expect(timer2).to_not be_valid
  end

  it "is not valid with invalid deadline" do
    timer1 = Timer.new(date: Date.today - 1.day, deadline: Time.current)
    timer2 = Timer.new(date: Date.today - 1.day, deadline: Time.current - 1.minute)
    expect(timer1).to_not be_valid
    expect(timer2).to_not be_valid
  end

  it 'should get usd value for today' do
    VCR.use_cassette("usd/today") do
      timer_responce = Timer.scrape
      timer_responce_with_date = Timer.scrape(Date.today.strftime("%d.%m.%Y"))
      expect(timer_responce).to eq(timer_responce_with_date)
    end
  end

  it 'should get usd value for 02.10.2019' do
    VCR.use_cassette("usd/02_10_2019") do
      date = "02.10.2019"
      timer_responce = Timer.scrape(date.to_date.strftime("%d.%m.%Y"))
      expect(timer_responce).to eq('65,0670')
    end
  end

end
