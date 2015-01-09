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

# params = {}
# entry            = Songs.new
# entry.attributes = params.slice('title', 'artist', 'album', 'genre', 'year', 'playCount', 'composer', 'urlAmazon', 'urlApple', 'image', 'artworkID')
# entry.length     = params[:time]
# entry.time       = Time.now
#
# if entry.image.empty? && entry.urlApple
#   aid      = params[:urlApple].slice(/id\d*\?/)[2..-2]
#   uri      = URI("https://itunes.apple.com/lookup?id=#{aid}")
#   response = Net::HTTP.get(uri)
#   # puts response
#   json        = JSON.parse(response)
#   entry.image = json["results"][0]["artworkUrl100"]
#   unless entry.save
#     puts entry.errors.full_messages
#   end
# end

run Template

#__ ECHO NEST
