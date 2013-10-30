require "test/unit"
require "rack/test"
require "./lib/rps.rb"

class RpsTest < Test::Unit::TestCase
	include Rack::Test::Methods
	
	def app
		Rack::Builder.new do
			use(Rack::Session::Cookie, {:key => 'rack.session', :domain => 'prueba.com', :secret => 'some_secret'})
			run RockPaperScissors::App.new
		end.to_app
	end
	#def setup
	#	@nav = Rack::Test::Session.new(Rack::MockSession.new(Rack::Session::Cookie.new(RockPaperScissors::App.new, :key => 'rack.session', :domain => 'prueba.com', :secret => 'some_secret')))
	#end
	
	#def app
	 #	Rack::Builder.new do
		#	run @nav
	#	end
	#		#run RockPaperScissors::App.new
	#	#end.to_app
#	end

	#############Añadir test

	def test_index
		get "/"
		#pust last_response.inspect
		assert last_response.ok?
	end

	def test_rock
		get "/?choice=rock"
		assert last_response.ok?
	end

	def test_paper
		get "/?choice=paper"
		assert last_response.ok?
	end

	def test_scissors
		get "/?choice=scissors"
		assert last_response.ok?
	end

#	def test_tie
#		computer_throw = "rock"
#		get "/?choice=rock"
#		assert last_response.body.include?("Result: You tied with the computer")
#	end

#	def test_win
#		computer_throw = "rock"
#		get "/?choice=paper"
#		assert last_response.body.include?("Result: Nicely done; paper beats rock")
#	end

#	def test_lose
#		computer_throw = "rock"
#		get "/?choice=scissors"
#		assert last_response.body.include?("Result: Ouch; rock beats scissors. Better luck next time!")
#	end

	def test_h1
		get "/"
		assert_match "<h1>Rock, Paper, Scissors</h1>", last_response.body
	end

	def test_h2
		get "/"
		assert_match "<h2>Choose a throw:</h2>", last_response.body
	end

	def test_title
		get "/"
		assert_match "<title>Rock, Paper, Scissors</title>", last_response.body
	end


end
