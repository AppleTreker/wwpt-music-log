DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db/dev.db")

class Songs
	include DataMapper::Resource

	property :id, Serial, :key => true
	property :time, EpochTime
	property :player, String, :required => true

	property :title, Text, :required => true
	property :artist, Text, :required => true
	property :album, Text, :required => true
	property :genre, String
	property :year, Integer
	property :length, Integer, :default => 0
	property :playCount, Integer
	property :composer, Text
	property :urlAmazon, Text
	property :urlApple, Text
	property :image, Text
	property :artworkID, String

end

DataMapper.finalize
DataMapper.auto_upgrade!
