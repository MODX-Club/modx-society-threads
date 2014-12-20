keyMirror = require "../../../../node_modules/react/lib/keyMirror"

module.exports =
  ActionTypes: keyMirror(
    CLICK_THREAD: null
    CREATE_MESSAGE: null
    CREATE_REPLY: null
    RECEIVE_RAW_CREATED_MESSAGE: null
    RECEIVE_RAW_MESSAGES: null
    COMMENT_DID_VOTE:null
  )
  PayloadSources: keyMirror(
    SERVER_ACTION: null
    VIEW_ACTION: null
  )
