'use strict';

var gulp = require('gulp'),
    requireDir = require('require-dir'),
    runSequence = require('run-sequence'),
    tasks = requireDir('./gulp', { recurse: true });

gulp.task('default', ['lint'], function(){
    runSequence ('unit-test', 'bundlelify');
});