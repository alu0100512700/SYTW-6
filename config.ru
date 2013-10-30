require './lib/rps'

builder = Rack::Builder.new do
	use Rack::Static, :urls => ["/public"]
	use Rack::ShowExceptions
	use Rack::Lint
	run RockPaperScissors::App.new
	use Rack::Session::Cookie,
		:key => 'rack.session',
		:domain => 'prueba.com',
		:secret => 'some_secret'

	run RockPaperScissors::App.new
end

use Rack::Server.start(
	:app => builder,
	:Port => 9292,
	:server => 'thin',
	:host => 'www.prueba.com'
)

