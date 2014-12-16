source 'https://rubygems.org'

ruby '2.1.2'

gem 'sinatra'
gem 'data_mapper'
gem 'rake'

group :development do
	gem 'sqlite3'
	gem 'dm-sqlite-adapter'
	gem 'thin'
end

group :production do
	gem 'pg'
	gem 'dm-postgres-adapter'
	#gem 'passenger'
	gem 'thin'
end
