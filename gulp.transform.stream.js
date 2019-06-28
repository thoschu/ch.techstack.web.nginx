const Fs = require('fs'),
    Stream = require('stream'),
    {Transform} = Stream;

class GulpTransformStream extends Transform {

    constructor(options = {objectMode: true}) {
        super(options);
        // __dirname and __filename
        // ...
    }

    _transform(chunk, encoding, callback) {
        console.log('TRANSFORM');
        console.log(chunk);
        console.log(Object.keys(chunk));
        console.log(chunk._symlink);
        console.log(chunk._contents);


        Fs.open(chunk._contents, 'r+', (err, handle) => {
            if (err) {
                console.error('######');
                console.error(err);
            } else {
                console.log(handle);
                console.log('******');
            }
        });

        this.push(chunk);
        callback();
    }

    _flush(callback) {
        console.log('FLUSH');
        callback();
    }
}

module.exports = {GulpTransformStream};
