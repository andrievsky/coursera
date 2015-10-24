// http://stackoverflow.com/questions/21128812/how-to-run-bash-command-in-gulp
// https://github.com/gulpjs/gulp
var gulp = require('gulp');
var del = require('del');
var ts = require('gulp-typescript');

gulp.task('clean', function(cb) {
    // You can use multiple globbing patterns as you would with `gulp.src`
    return del(['build/**'], cb);
});

gulp.task('ts', function () {
    return gulp.src('src/**/*.ts')
        .pipe(ts({
            target: 'ES5',
            noImplicitAny: false,
            removeComments: false,
            preserveConstEnums: true,
            sourceMap: true,
            outFile: 'app.js'
        }))
        .pipe(gulp.dest('build/'));
});

gulp.task('test', function () {
    return gulp.src('test/**/*.ts')
        .pipe(ts({
            target: 'ES5',
            noImplicitAny: false,
            removeComments: false,
            preserveConstEnums: true,
            sourceMap: true,
            module: 'commonjs'
        }))
        .pipe(gulp.dest('spec/'));
});


// Watch Files For Changes
gulp.task('watch', function() {
    gulp.watch('test/**/*.ts', ['test']);
    gulp.watch('src/**/*.ts', ['ts']);
});

gulp.task('default', ['clean'], function() {
    gulp.start('ts', 'test', 'watch');
});