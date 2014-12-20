_ = require '../../../../node_modules/lodash/lodash'
rsvp = require("../../../../node_modules/rsvp/rsvp.js/rsvp.amd")
xhr = require '../../../../node_modules/superagent/superagent'
Config = require '../config'
Helpers = require './helpers'

Request =
  init: (props={}) ->
    props = _.merge
      actionKey:'pub_action'
      connectorsUrl:no
      connector:no
      dataType: "form"
      eventDelimiter: "/"
      method:'post'
    ,props

    for k,i of props
      Object.defineProperty @,k,
        enumerable:true
        value:i
        writable:true

    @

  getActionUrl: (action = {}) ->
    url = @connectorsUrl + @connector
    "#{url or Config.url}?#{action.key or @actionKey}=#{action.name}"

  getEventName: (event, slice = no) ->
    event = event.split @eventDelimiter
    event.shift() if slice
    event.join "."

  run: (action, data, event) ->
    return new rsvp.Promise (resolve,reject) =>

      callback =
        (error,res) =>

          if error?
            Helpers.debug ->
              console.warn "Request failure: #{res.error.message}"

            reject.res
          else

            if res.error
              Helpers.debug ->
                console.warn "Response failure: #{res.error.message}"

              resolve
                event: "#{prefix}#{event}"
                response: res

            else
              resp = JSON.parse res.text

              event = @getEventName(
                if (event && event.constructor is String) then event else action
              )

              prefix = "failure."
              switch @dataType
                when "html"
                  prefix = "success."
                else
                  prefix = "success." if resp.success

              @processResponse resp

              resolve
                event: "#{prefix}#{event}"
                response: resp

      switch @method
        when 'post'
          xhr(@method, @getActionUrl(name: action))
            .type @dataType
            .send data
            .end callback
        else
          xhr(@method, @getActionUrl(name: action))
            .type @dataType
            .query data
            .end callback

  processResponse: (resp) ->
    if resp.success
      @onSuccess resp.message, resp
    else
      @onFailure resp.message, resp

  onSuccess: ->
  onFailure: ->

module.exports = Request
