CHANGE_EVENT = "change"

StoreMixin =
  emitChange: ->
    @emit CHANGE_EVENT
    return

  addChangeListener: (callback) ->
    @on CHANGE_EVENT, callback
    return

  removeChangeListener: (callback) ->
    @removeListener CHANGE_EVENT, callback
    return

module.exports = StoreMixin
