gulp = require('gulp')
mocha = require('gulp-mocha')
gutil = require('gulp-util')

# テストタスク
gulp.task 'test', ->
  gulp.src(['srcipts/**/*.coffee', 'test/**/*.coffee'])
    .pipe mocha {reporter: 'spec'}

# ファイル監視＆テスト実行タスク
gulp.task 'watch', ->
  gulp.watch(['scripts/**/*.coffee', 'test/**/*.coffee'], ['test'])

