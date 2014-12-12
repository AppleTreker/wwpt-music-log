require 'rubygems'
require 'bundler'
require 'uri'
require 'net/http'
require 'json'

Bundler.require

require './app.rb'

# Routes
require './routes/main.rb'

# Helpers
require './helpers/common.rb'

require './models/songs.rb'

run Template

#__ ECHO NEST
