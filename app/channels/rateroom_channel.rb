class RateroomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "rateroom_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
