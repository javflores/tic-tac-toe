'use strict';

var gulp = require('gulp'),
    jshint = require('gulp-jshint'),
    stylish = require('jshint-stylish'),
    jshint_jsx = require('jshint-jsx');

gulp.task('lint', function() {
    return gulp.src('./components/*.js')
        .pipe(jshint({
            linter: jshint_jsx.JSXHINT
        }))
        .pipe(jshint.reporter(stylish))
        .pipe(jshint.reporter('fail'));
});