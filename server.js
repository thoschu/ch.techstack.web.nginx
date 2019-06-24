let test = 1;

const http = require('http'),
    fs = require('fs'),
    path = require('path'),
	url = require('url'),
	util = require('util'),
    stream = require('stream'),
    port = 8888;

console.log('####');
// console.log(__dirname);
console.log(path.dirname(__filename));
console.log('*****');


const writeStream = fs.createWriteStream(`${__dirname}${path.sep}license.txt`);
const readStream = fs.createReadStream(`${__dirname}${path.sep}package.json`, {encoding: 'utf8', highWaterMark: 128});


class CopyTransformStream extends stream.Transform {
    _transform(chunk, encoding, callback) {
        //this.push(chunk.toString().toUpperCase());
        callback(null, chunk.toString().toUpperCase());
    }
}

const copy = new CopyTransformStream();

readStream.pipe(copy).pipe(writeStream);

// readStream.on('readable', () => {
//     console.log(readStream.isPaused());
//     console.log(readStream.read());
// });
//
// readStream.on('end', () => {
//     console.log('end');
// });
//
// readStream.on('error', (err) => {
//     console.error(err);
// });
//
// readStream.on('close', () => {
//     console.log('close');
// });

http.createServer(function (req, res) {
    // console.log(req);
    // console.log(Object.keys(req));
    // console.log(req.url);
    // console.log(url.parse(req.url, true));

	test = 2;

	const jsonString = util.inspect(req).replace("IncomingMessage ", "");

    test = 13;

    // debugger;

    const template = `
		<html>
			<head>
				<meta charset="utf-8">
				<title>Node.js Demo</title>
				<link rel="icon" href="//www.iconj.com/large_icon.php?pid=pqdcukftfy" type="image/x-icon">
			</head>
			<body>
				<h1 style="color: blue;">My First Heading</h1>
				<p style="color:orange;">${url.parse(req.url, true).query.name}</p>
				<p>${jsonString}</p>
			</body>
		</html>
	`;

    //readStream.pipe(req);

    console.time('foo');
    res.writeHead(200, {
        'content-type': 'text/html; charset=uft-8'
    });
    console.timeEnd('foo');

    test = 77;

    res.write('<!DOCTYPE html>');

    setTimeout(function fn(arg) {
		res.end(arg);
    }, 1500, template);


}).listen(port, function () {
    console.log(`Server is listening to: http://localhost:${port}`);
    console.log(process.getuid);
    // console.trace();
});
