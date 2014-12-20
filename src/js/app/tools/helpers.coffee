module.exports = {
  debug:(callback) ->
    callback() if location.hash.match '#!dev'
}
