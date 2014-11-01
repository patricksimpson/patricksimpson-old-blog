# Paths
BASE_DIR            = 'app/'
BASE_TEMPLATE_DIR   = BASE_DIR + 'templates/'
BASE_SCRIPTS_DIR    = BASE_DIR + 'scripts/'
BASE_VENDOR_DIR     = 'bower_components/'
BASE_ASSETS_DIR     = BASE_DIR + 'assets/'
BASE_STYLES_DIR     = BASE_DIR + 'styles/'
BASE_POSTS_DIR      = BASE_DIR + 'posts/'

# Harp paths
HARP_DIR           = 'harp/'
HARP_TEMPLATE_DIR   = HARP_DIR
HARP_SCRIPTS_DIR    = HARP_DIR + 'scripts/'
HARP_VENDOR_DIR     = HARP_DIR + 'scripts/vendors/'
HARP_ASSETS_DIR     = HARP_DIR + 'assets/'
HARP_STYLES_DIR     = HARP_DIR + 'styles/'
HARP_POSTS_DIR      = HARP_DIR + 'posts/'

# Config
TEMPLATE_EXT       = '.jade'
STYLE_EXT         = '.*'
SCRIPT_EXT         = '.coffee'

# libs
fs          = require('fs')
moment      = require('moment')
mkdirp      = require('mkdirp')
path        = require("path")
gulp        = require("gulp")
browserSync = require("browser-sync")
reload      = browserSync.reload
harp        = require("harp")
markdown    = require("gulp-markdown-to-json")
rename      = require("gulp-rename")
extend      = require('gulp-extend')
wrap        = require('gulp-wrap')
glob        = require('glob')
es          = require('event-stream')
gutil       = require('gulp-util')
concat      = require('gulp-concat-util')
del         = require('del')
rename      = require("gulp-rename")
runSequence = require('gulp-run-sequence')
replace     = require('gulp-replace')
html2jade   = require('gulp-html2jade')
md          = require('html-md')

gulp.task "serve", ->
  harp.server __dirname+'/harp',
    port: 9000
  , ->
    browserSync
      proxy: "localhost:9000"
      open: false
      notify:
        styles: [
          "opacity: 0"
          "position: absolute"
        ]

    gulp.watch "app/styles/*", ->
      reload "main.css",
        stream: true

    gulp.watch [HARP_DIR + '*', HARP_POSTS_DIR + '*', HARP_STYLES_DIR + '*'], ->
      reload()

    gulp.watch [BASE_TEMPLATE_DIR + '*', BASE_STYLES_DIR + '*', BASE_SCRIPTS_DIR + '*'], ['post']

    gulp.watch ["posts/*.md"], ['post']

copyFiles = (input, output) ->
  console.log 'copy files:' + input
  files = glob.sync(input)
  stream = files.map((file) ->
    dir = path.dirname(file)
    filename = path.basename(file)
    gulp.src(file)
      .pipe(rename(output + filename))
      .pipe(gulp.dest('./'))
  )
  es.merge.apply(es, stream)
  console.log 'copy complete.'

postInstall = ->
  # Copy base templates
  console.log 'post install'
  copyFiles(BASE_TEMPLATE_DIR + '*' + TEMPLATE_EXT, HARP_DIR)
  copyFiles(BASE_SCRIPTS_DIR + '*' + SCRIPT_EXT, HARP_SCRIPTS_DIR)
  copyFiles(BASE_STYLES_DIR + '*' + STYLE_EXT, HARP_STYLES_DIR)
  copyFiles(BASE_ASSETS_DIR + '*', HARP_ASSETS_DIR)
  files = glob.sync(BASE_TEMPLATE_DIR + '*' + TEMPLATE_EXT)

gulp.task 'post-clean', (cb) ->
  del('harp', cb)

gulp.task 'post-setup', ->
  mkdirp('./harp')
  postInstall()

gulp.task 'post-markdown', ->
  gulp.src('posts/*.md')
    .pipe(markdown(
      smartypants: true
    ))
    .pipe(gulp.dest('harp/posts/meta'))

gulp.task 'post-json', ->
  files = glob.sync('harp/posts/meta/*.json')
  streams = files.map((file) ->
    dir = path.dirname(file)
    filename = path.basename(file, '.json')
    data = JSON.parse(fs.readFileSync(file, 'utf8'))
    console.log 'create the data file'
    # Remove the body, we will partialize this later.
    delete data.body
    data.order = moment(data.date).unix()
    gulp.src(file)
      .pipe(wrap('{"'+ filename + '": '+ JSON.stringify(data) + '}'))
      .pipe(rename(dir + '/temp/' +'_' + data.order + '-' + filename + '.json'))
      .pipe(gulp.dest('./'))
  )
  es.merge.apply(es, streams)

gulp.task 'post-data', ->
  gulp.src('harp/posts/meta/temp/*.json')
    .pipe(extend('harp/posts/_data.json'))
    .pipe(gulp.dest('./'))

gulp.task 'post-compile', ->
  gulp.src('app/templates/_posts_index.jade')
  .pipe(rename('harp/posts/index.jade'))
  .pipe(gulp.dest('./'))
  # Glob the json data files.
  files = glob.sync('harp/posts/meta/*.json')
  streams = files.map((file) ->
    dir = path.dirname(file)
    filename = path.basename(file, '.json')
    data = JSON.parse(fs.readFileSync(file, 'utf8'))
    body = data.body
    partial = 'meta/' + filename + '.html'
    fs.writeFile('harp/posts/' + partial, body, (error) ->
      if error
        console.log error
    )
    gulp.src('app/templates/_layout-posts.jade')
    .pipe(rename('harp/posts/' + filename + '.jade'))
    .pipe(replace('%BODY%', partial))
    .pipe(gulp.dest('./'))

  )
  es.merge.apply(es, streams)

gulp.task "default", ["go"]

gulp.task 'go', ->
  runSequence('post', 'serve')

gulp.task 'post', ->
  runSequence('post-clean', 'post-setup', 'post-markdown', 'post-json','post-data', 'post-compile')
