var gulp  = require('gulp');
var config= require('../config');

gulp.task('watch', ['setWatch', 'build'], function() {
  // gulp.watch(config.images.src, ['images']);
  // gulp.watch(config.less.src, ['less']);
});
