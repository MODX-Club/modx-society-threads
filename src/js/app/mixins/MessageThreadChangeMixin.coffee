MessageStore = require "../stores/MessageStore"
ThreadStore = require "../stores/ThreadStore"

module.exports =
  componentDidMount: ->
    MessageStore.addChangeListener @_onChange
    ThreadStore.addChangeListener @_onChange

  componentWillUnmount: ->
    MessageStore.removeChangeListener @_onChange
    ThreadStore.removeChangeListener @_onChange
