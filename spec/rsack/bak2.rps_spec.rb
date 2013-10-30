require 'spec_helper'
require 'pp'
require 'rack/request'
require 'rack/mock'
require 'rps.rb'

describe Rsack::Server do

	#let(:server) { Rack::MockRequest.new(RockPaperScissors::App.new) }
	def server
		Rack::MockRequest.new(Rsack::Server.new(Rack::Session::Cookie.new(RockPaperScissors::App.new, :key => 'rack.session', :domain => 'prueba.com', :secret => 'some_secret')))
	end

	context '/' do
		it "should return a 200 code" do
			response = server.get('/')
			#p response.body
			response.status.should == 200
		end
	end

	context "/" do
		it "should return a 200 code" do
			response = server.get("", :input => "choice=rock")
			response.status.should == 200


	
			computer_throw = 'rock'
			puts "========================================="
			pp self
			response = server.get("", :input => "choice=rock")
			p "La clase de response es: " + response.class.to_s
			p response.body
			response.body.should match(/Result: You tied with the computer/)
		
		end
	end
end
