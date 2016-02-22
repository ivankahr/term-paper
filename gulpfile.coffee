autoprefixer  = require 'gulp-autoprefixer'
coffeelint    = require 'gulp-coffeelint'
stylint       = require 'gulp-stylint'
gulp          = require 'gulp'
plumber       = require 'gulp-plumber'
stylus        = require 'gulp-stylus'
minify        = require 'gulp-minify-css'

coffeeFiles = [
    '*.coffee'
    'controllers/*.coffee'
    'helpers/*.coffee'
    'models/*.coffee'
]

gulp.task 'lint', ['stylus-lint', 'coffee-lint']
gulp.task 'default', ['lint', 'stylus']
gulp.task 'dev', ['default', 'watch']

gulp.task 'watch', ->
    gulp.watch coffeeFiles, ['coffee-lint']
    gulp.watch 'stylus/**/*.styl', ['stylus-lint', 'stylus']

gulp.task 'stylus-lint', ->
    gulp.src 'stylus/**/*.styl'
        .pipe stylint()
        .pipe stylint.reporter()

gulp.task 'coffee-lint', ->
    gulp.src coffeeFiles
        .pipe coffeelint()
        .pipe coffeelint.reporter()

gulp.task 'stylus', ->
    gulp.src 'stylus/main.styl'
        .pipe plumber()
        .pipe stylus()
        .pipe autoprefixer()
        .pipe minify()
        .pipe gulp.dest 'static/css'
