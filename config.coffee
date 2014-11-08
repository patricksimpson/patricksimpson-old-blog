# Paths
BASE_DIR            = 'app/'
BASE_TEMPLATE_DIR   = BASE_DIR + 'templates/'
BASE_SCRIPTS_DIR    = BASE_DIR + 'scripts/'
BASE_VENDOR_DIR     = 'bower_components/'
BASE_ASSETS_DIR     = BASE_DIR + 'assets/'
BASE_STYLES_DIR     = BASE_DIR + 'styles/'
BASE_POSTS_DIR      = 'posts/'

# Harp paths
HARP                = 'harp'
HARP_DIR            = HARP + '/'
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
uglify      = require('gulp-uglify')
minifyCSS    = require('gulp-minify-css')

gulp.task 'serve', ->
  harp.server __dirname + '/' + HARP,
    port: 9000
  , ->
    browserSync
      proxy: 'localhost:9000'
      open: false
      notify:
        styles: [
          'opacity: 0'
          'position: absolute'
        ]

    gulp.watch 'app/styles/*', ->
      reload "main.css",
        stream: true

    gulp.watch [
      HARP_POSTS_DIR + '/_data.json'
      ], ->
      reload()

    gulp.watch [
      BASE_POSTS_DIR + '*.md'
      BASE_TEMPLATE_DIR + '*'
      BASE_STYLES_DIR + '*'
      BASE_SCRIPTS_DIR + '*'], ['post']

copyFiles = (input, output) ->
  files = glob.sync(input)
  stream = files.map((file) ->
    dir = path.dirname(file)
    filename = path.basename(file)
    gulp.src(file)
      .pipe(rename(output + filename))
      .pipe(gulp.dest('./'))
  )
  es.merge.apply(es, stream)

postInstall = ->
  # Copy base templates
  copyFiles(BASE_TEMPLATE_DIR + '*' + TEMPLATE_EXT, HARP_DIR)
  copyFiles(BASE_SCRIPTS_DIR + '*' + SCRIPT_EXT, HARP_SCRIPTS_DIR)
  copyFiles(BASE_STYLES_DIR + '*' + STYLE_EXT, HARP_STYLES_DIR)
  files = glob.sync(BASE_TEMPLATE_DIR + '*' + TEMPLATE_EXT)
  gulp.src( [ BASE_VENDOR_DIR + '*/**' ])
    .pipe(gulp.dest(HARP_VENDOR_DIR))
  gulp.src( [ BASE_ASSETS_DIR + '*/**' ])
    .pipe(gulp.dest(HARP_ASSETS_DIR))

gulp.task 'post-clean', (cb) ->
  del('harp', cb)

gulp.task 'post-setup', ->
  mkdirp('./' + HARP)
  postInstall()
  copyFiles(BASE_TEMPLATE_DIR + '_posts.json', HARP_POSTS_DIR + 'meta/temp/')

gulp.task 'post-markdown', ->
  gulp.src('posts/*.md')
    .pipe(markdown(
      smartypants: true
    ))
    .pipe(gulp.dest(HARP_POSTS_DIR + 'meta'))

gulp.task 'post-json', ->
  files = glob.sync(HARP_POSTS_DIR + 'meta/*.json')
  streams = files.map((file) ->
    dir = path.dirname(file)
    filename = path.basename(file, '.json')
    data = JSON.parse(fs.readFileSync(file, 'utf8'))
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
  gulp.src(HARP_POSTS_DIR + 'meta/temp/*.json')
    .pipe(extend(HARP_POSTS_DIR + '_data.json'))
    .pipe(gulp.dest('./'))
  gulp.src(BASE_TEMPLATE_DIR + '*.json')
    .pipe(gulp.dest(HARP_DIR))

gulp.task 'post-compile', ->
  gulp.src(BASE_TEMPLATE_DIR + '_posts_index.jade')
  .pipe(rename(HARP_POSTS_DIR + 'index.jade'))
  .pipe(gulp.dest('./'))
  files = glob.sync(HARP_POSTS_DIR + 'meta/*.json')
  streams = files.map((file) ->
    dir = path.dirname(file)
    filename = path.basename(file, '.json')
    data = JSON.parse(fs.readFileSync(file, 'utf8'))
    body = data.body
    partial = 'meta/' + filename + '.html'
    fs.writeFile(HARP_POSTS_DIR + partial, body, (error) ->
        if error
          console.log error
    )
    gulp.src(BASE_TEMPLATE_DIR + '_layout-posts.jade')
    .pipe(rename(HARP_POSTS_DIR + filename + '.jade'))
    .pipe(replace('%BODY%', partial))
    .pipe(gulp.dest('./'))

  )
  es.merge.apply(es, streams)

gulp.task 'before:concat', ->

  gulp.src(HARP_SCRIPTS_DIR + 'vendors/**/*.js')
    .pipe(concat('vendors.js'))
    .pipe(concat.header('// file: <%= file.path %>\n'))
    .pipe(concat.footer('\n// end\n'))
    .pipe(gulp.dest(HARP_SCRIPTS_DIR))

gulp.task 'after:uglify', ->
  # After harp compile.
  # gulp.src('dist/scripts/*.js')
  #   .pipe(uglify())
  #   .pipe(gulp.dest('dist/scripts/'))
  gulp.src('dist/css/*.css')
    .pipe(minifyCSS())
    .pipe(gulp.dest('dist/css/'))

gulp.task 'default', ->
  runSequence('post', 'serve')

gulp.task 'post', ->
  runSequence('post-clean', 'post-setup', 'post-markdown', 'post-json','post-data', 'post-compile', 'before')

gulp.task 'before', ['before:concat']
gulp.task 'after', ['after:uglify']

