dest = "./bundle"
src  = './src'

_ = require 'lodash'
fs = require('fs')

list = fs.readdirSync "#{__dirname}/../src/js/pages"

multipleBundles = []

_(list).each (file) ->

  _file = file.split('.')
  _file[_file.length-1] = 'js'

  multipleBundles.push {
    dest:dest
    entries:"#{src}/js/pages/#{file}"
    outputName:_file.join('.')
  }

# multipleBundles.push {
#   entries: './src/javascript/app.coffee'
#   dest: dest
#   outputName: 'app.js'
# }

module.exports =
  serverport: 3000
  browserSync:
    server:
      # src is included for use with sass source maps
      baseDir: [dest, src]
    files: [
      # Watch everything in build
      "#{dest}/**",
      # Exclude sourcemap files
      "!#{dest}/**.map"
    ]

  scripts:
    src : "#{src}/js/app/**"
    dest: "#{dest}/app"

  less:
    src : "#{src}/css/styles.less"
    dest: "#{dest}/css"

  images:
    src : "#{src}/images/**/*"
    dest: "#{dest}/images"

  dist:
    root: dest

  browserify:
    # // Enable source maps
    debug: true
    # // Additional file extentions to make optional
    extensions: ['.coffee', '.cjsx']
    # // A separate bundle will be generated for each
    # // bundle config in the list below
      # bundleConfigs: [
      #   {
      #     entries: ['./src/javascript/app.coffee']
      #     dest: dest
      #     outputName: 'app.js'
      #   }
      # ]
    bundleConfigs:multipleBundles
