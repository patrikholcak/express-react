require('dotenv').load()

express = require 'express'
fs = require 'fs'
morgan = require 'morgan'

handleRoutes = require './handleRoutes'
handleErrors = require './handleErrors'

# Set up the server
app = express()
app.set('port', process.env.PORT or 3000)
app.set('hostname', process.env.HOSTNAME or 'localhost')


# Logging
if process.env.NODE_ENV is 'production'
  if process.env.MORGAN_LOG_FILE
    morganLog = fs.createWriteStream "#{__dirname}/../#{process.env.MORGAN_LOG_FILE}",
      flags: 'a'

  morgan.token 'remote-addr', (req, res) ->
    ffHeaderValue = req.headers['x-forwarded-for']
    return ffHeaderValue or req.connection.remoteAddress

  app.use morgan 'combined',
    stream: morganLog
    skip: (req, res) ->
      switch process.env.MORGAN_LOG_LEVEL
        when 'info' then return res.statusCode > 400
        when 'access' then return res.statusCode < 200 and res.statusCode > 400
        when 'debug' then return false
        else return res.statusCode < 400
else
  app.use morgan('dev')


# Add static directory
app.use express.static("#{__dirname}/public")


# Handle routes
app.use handleRoutes


# Handle server-side errors
app.use handleErrors

# Start the server
app.listen app.get('port'), app.get('host'), ->
  return if process.env.NODE_ENV is 'production'

  console.log "\x1b[32m[server]\x1b[0m Up and running.",
    "\nPort: #{app.get('port')}"
    "\nHost: #{app.get('hostname')}"
    "\nBuild: #{process.env.BUILD_TIMESTAMP}."
    "\nLog level: '#{process.env.MORGAN_LOG_LEVEL}'"
