require 'twitter'
require 'unirest'
require 'json'

class BigBen
	attr_reader :client

	def initialize
		keys = File.readlines('twitterkeys.dat')
		$client = Twitter::REST::Client.new do |config|
  			config.consumer_key        = keys[0].strip
  			config.consumer_secret     = keys[1].strip 
  			config.access_token        = keys[2].strip
  			config.access_token_secret = keys[3].strip
		end
	end

	def tweet(message)

		if message.length < 141
			$client.update(message)
		else
			puts "Too long, must be 140 characters or less"
		end

	end

	def generate_quote 
	#category = ""

		#while category != "Famous"
			#response = Unirest.post "https://andruxnet-random-famous-quotes.p.mashape.com/cat=movies",
			#  headers:{
			#    "X-Mashape-Key" => "DxjO5QCacimshdoYTwnWaHJ9GLIWp1XBuKvjsn8phRFfKfY0L1",
			#    "Content-Type" => "application/x-www-form-urlencoded",
			#    "Accept" => "application/json"
	  		#}

	  	response = Unirest.get "https://theysaidso.p.mashape.com/quote?maxlength=120",
  			headers:{
    			"X-Mashape-Key" => "iAdAjNK1A4mshX6A4VCJJ6uKt2kUp18eUI7jsn1RB9S7DIoDiy",
    			"Accept" => "application/json"
  			}
		
			quote = response.body["contents"]["quote"]
			#quote = response.body["quote"]
			quote = quote + " -Benjamin Franklin"

			#category = response.body["category"]
		#end

	return quote

	end


end

ben = BigBen.new
ben.tweet(ben.generate_quote)


