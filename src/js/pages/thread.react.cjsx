"use_strict"

React = require 'react'
Thread = require '../app/components/SocietyThread.react'
ChatWebAPIUtils = require '../app/utils/ChatWebAPIUtils'

ChatWebAPIUtils.getAllMessages()

React.render(
  <Thread />
  document.getElementById('commentsSection')
)
