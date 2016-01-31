'use strict';

var gulp = require('gulp'),
     exec = require('child_process').exec;

 gulp.task('unit-test', function (cb) {
     exec('npm test', function (err, stdout, stderr) {
         console.log(stdout);
         console.log(stderr);
         cb(err);
     });
 });