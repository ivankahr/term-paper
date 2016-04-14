autoprefixer  = require 'gulp-autoprefixer'
coffeelint    = require 'gulp-coffeelint'
stylint       = require 'gulp-stylint'
gulp          = require 'gulp'
plumber       = require 'gulp-plumber'
stylus        = require 'gulp-stylus'
minify        = require 'gulp-minify-css'
concat        = require 'gulp-concat'
uglify        = require 'gulp-uglify'
jade          = require 'gulp-jade'
coffee        = require 'gulp-coffee'

coffeeFiles = [
    '*.coffee'
    'controllers/*.coffee'
    'helpers/*.coffee'
    'models/*.coffee'
    'frontend/*.coffee'
]

jsFiles = [
    'bower_components/angular/angular.min.js'
    'bower_components/angular-route/angular-route.min.js'
    'static/app.js'
]

gulp.task 'lint', ['stylus-lint', 'coffee-lint']
gulp.task 'default', ['lint', 'stylus', 'js', 'jade']
gulp.task 'dev', ['default', 'watch']

gulp.task 'watch', ->
    gulp.watch coffeeFiles, ['coffee-lint']
    gulp.watch 'frontend/*.coffee', ['js']
    gulp.watch 'stylus/**/*.styl', ['stylus-lint', 'stylus']

gulp.task 'stylus-lint', ->
    gulp.src 'stylus/**/*.styl'
        .pipe stylint()
        .pipe stylint.reporter()

gulp.task 'coffee-lint', ->
    gulp.src coffeeFiles
        .pipe coffeelint()
        .pipe coffeelint.reporter()

gulp.task 'coffee', ->
    gulp.src 'frontend/*.coffee'
        .pipe plumber()
        .pipe coffee()
        .pipe concat 'app.js'
        .pipe gulp.dest 'static'

gulp.task 'stylus', ->
    gulp.src 'stylus/main.styl'
        .pipe plumber()
        .pipe stylus()
        .pipe autoprefixer()
        .pipe minify()
        .pipe gulp.dest 'static'

gulp.task 'jade', ->
    gulp.src ['views/*.jade', '!views/index.jade']
        .pipe plumber()
        .pipe jade()
        .pipe gulp.dest 'static/views'

gulp.task 'js', ['coffee'], ->
    gulp.src jsFiles
        .pipe concat 'min.js'
        .pipe uglify mangle: no
        .pipe gulp.dest 'static'
