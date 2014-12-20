React = require 'react'
MessageStore = require "../stores/MessageStore"
ThreadStore = require "../stores/ThreadStore"
MessageThreadChangeMixin = require '../mixins/MessageThreadChangeMixin'

getStateFromStores =
  ->
    messages: MessageStore.getCount()
    thread: ThreadStore.getCurrent()

ThreadSection = React.createClass
  mixins:[MessageThreadChangeMixin]

  getInitialState:() ->
    getStateFromStores()

  _onChange: ->
    @setState getStateFromStores()

  render: (args) ->
    <section className="threadSection">
      <h3>Comments{"(#{@state.messages})" if @state.messages}</h3>
    </section>

module.exports = ThreadSection
