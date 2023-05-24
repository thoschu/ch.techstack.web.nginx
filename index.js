const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: 'thoschulte@googlemail.com',
        pass: 'xxx'
    }
});

const mailOptions = {
    from: 'thoschulte@googlemail.com',
    to: 'thoschulte@googlemail.com',
    subject: 'Sending Email using Node.js',
    text: 'That was easy xxxxxxxxxxx!!!'
};

transporter.sendMail(mailOptions, function(error, info){
    if (error) {
        console.log(error);
    } else {
        console.log('Email sent: ' + info.response);
    }
});
