'use strict';

var gulp = require('gulp'),
    browserify = require('browserify'),
    source = require('vinyl-source-stream'),
    babelify = require('babelify'),
    del = require('del');

gulp.task('delete-lib', function(done) {
    return del(['./lib' + '/**'], done);
});

gulp.task('copy', ['delete-lib'], function(){
    return gulp.src('./components/**')
        .pipe(gulp.dest('./lib'));
});

gulp.task('bundlelify', ['copy'], function(){
    return browserify("./components/index.js")
        .transform("babelify", {presets: ["es2015", "react"]})
        .bundle()
        .pipe(source('app.js'))
        .pipe(gulp.dest('./lib'));
});