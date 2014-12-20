ThreadStore = require '../stores/ThreadStore'
SocietySession = require '../tools/SocietySession'

module.exports =
  convertRawMessage: (rawMessage) ->
    {childs, parent, id, rating, createdon, text, thread_id} = rawMessage

    id: id
    editing: no
    parent: parent
    childs: if childs? then childs.split(',') else []
    rating: Math.round rating
    threadId: thread_id
    date: new Date(createdon)
    text: text
    avatar: rawMessage.author_avatar
    authorName: rawMessage.author_username

  prepareCreatedMessage: (text,options) ->
    id: "m_#{Date.now()}"
    date: new Date()
    target_id: SocietySession.Topic.targetId
    target_class: SocietySession.Topic.targetClass
    text: text
    parent:options.replyTo
