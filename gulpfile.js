const {src, dest, series, parallel} = require('gulp'),
    {GulpTransformStream} = require('./gulp.transform.stream');

const streamTask = () => {
        const gTransfStream = new GulpTransformStream();
        return src('./package.json')
            .pipe(gTransfStream)
            //.pipe(dest('output'));
    },
    clean = cb => {
        console.log(`// do your clean foo`);
        cb();
    },
    javascript = (cb) => {
        console.log(`// do your javascript foo`);
        const gTransfStream = new GulpTransformStream();
        //console.log(gTransfStream);
        cb();
    };

exports.build = series(clean, parallel(streamTask, javascript));
exports.default = streamTask;
exports.test = javascript;