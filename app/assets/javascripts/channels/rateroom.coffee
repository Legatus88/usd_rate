App.rateroom = App.cable.subscriptions.create "RateroomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    #console.log("123121313")
    #console.log(data.foo)

    #return '123'
    #console.log("data received": data)
    $('#rate-container').append data['foo']
