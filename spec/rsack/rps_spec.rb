require 'spec_helper'
require 'pp'

describe Rsack::Server do

	#let(:server) { Rack::MockRequest.new(RockPaperScissors::App.new) }
	def server
		Rack::MockRequest.new(Rsack::Server.new(Rack::Session::Cookie.new(RockPaperScissors::App.new, :key => 'rack.session', :domain => 'prueba.com', :secret => 'some_secret')))
	end

	context '/' do
		it "should return a 200 code" do
			response = server.get('/')
			p response.body
			response.status.should == 200
		end
	end

	context "/" do
		it "should return a 200 code" do
			response = server.get("/", {:input => "choice=rock"})
			response.status.should == 200
		end
	end

	context "/?choice='paper'" do
		it "should return a 200 code" do
			response = server.get("/?choice='paper'")
			response.status.should == 200
		end
	end

	context "/?choice='scissors'" do
		it "should return a 200 code" do
			response = server.get("/?choice='scissors'")
			response.status.should == 200
		end
	end

	context "match" do
	#	it "should exist Rock, Paper, Scissors" do
	#	response = server.get('/')
	#	response.should match(/Rock, Paper, Scissors/)
	#	end

		it "should exist Choose a throw:" do
		response = server.get('/')
		response.should match(/Choose a throw:/)
		end

		it "should exist Play:" do
		response = server.get('/')
		response.should match(/Play:/)
		end

		it "should exist Won:" do
		response = server.get('/')
		response.should match(/Won:/)
		end

		it "should exist Lost:" do
		response = server.get('/')
		response.should match(/Lost:/)
		end

		it "should exist Tied:" do
		response = server.get('/')
		response.should match(/Tied:/)
		end
	end
end
