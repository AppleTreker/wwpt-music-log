class Template < Sinatra::Base
	get '/' do
		@songs    = Songs.last(5, :offset => 1)
		@now_song = Songs.last
		if @now_song
			erb :home
		else
			erb :no_songs
		end
	end

	get '/all' do
		@songs = Songs.all.reverse
		erb :all
	end

	post '/search' do
		range = @params[:range] ? @params[:range] : 1
		if params[:time].to_i==12
			hour = (params[:PM] ? 12 : 0)
		else
			hour = params[:time].to_i + (params[:PM] ? 12 : 0)
		end
		time         = Time.local(*params[:day].split(':'), hour)
		@songs       = Songs.all(:time.lt => (time.to_i + range.to_f*60*60), :time.gt => (time.to_i - range.to_f*60*60))
		@search_time = time
		erb :search
	end

	post '/more' do
		@songs = Songs.last(10, :time.lt => params[:loadTime], :offset => ((params[:page].to_i - 1) * 10) - 4)
		erb :rows, :layout => false
	end

	post '/log/:secret' do
		halt 401 unless ENV['LOG_SECRET'] == params[:secret]
		halt 403 unless true || ENV['LOG_IP'] == request.ip || ENV['TESTING']

		entry            = Songs.new
		entry.attributes = params.slice('title', 'artist', 'album', 'genre', 'year', 'playCount', 'composer', 'urlAmazon', 'urlApple', 'image', 'artworkID')
		entry.length     = params[:time]
		entry.time       = Time.now

		if entry.image.empty? && entry.urlApple
			aid      = params[:urlApple].slice(/id\d*\?/)
			aid = aid[2..-2] if aid
			uri      = URI("https://itunes.apple.com/lookup?id=#{aid}")
			response = Net::HTTP.get(uri)
			# puts response
			json        = JSON.parse(response)
			entry.image = json["results"][0]["artworkUrl100"]
			unless entry.save
				puts entry.errors.full_messages
			end
		end
	end

	get '/whatip' do
		return request.ip.to_s
	end
end