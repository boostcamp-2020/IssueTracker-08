const express = require('express');
const cookieParser = require('cookie-parser');
const logger = require('morgan');
const swaggerJSDoc = require('swagger-jsdoc');
const swaggerUi = require('swagger-ui-express');

const indexRouter = require('./routes/index');

const swaggerDefinition = {
  info: {
    title: 'IssueTracker-08',
    version: '1.0.0',
    description: 'IssueTracker API Document',
  },
  basePath: '/api',
};

const options = {
  swaggerDefinition,
  apis: [
    './api/issue/issue.router.js',
    './api/milestone/milestone.router.js',
    './api/signin/signin.router.js',
    './api/user/user.router.js',
  ],
};

const swaggerSpec = swaggerJSDoc(options);

const app = express();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

app.use('/', indexRouter);
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));
// error handler
app.use(function (err, req, res, next) {
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};
});

module.exports = app;
