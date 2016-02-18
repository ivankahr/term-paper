exec = require './helpers/exec_sql'
path = require 'path'

exec path.join __dirname, './sql/create.sql'
