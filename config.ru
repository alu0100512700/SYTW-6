require './lib/rps'

use Rack::Static, :urls => ["/public"]
use Rack::ShowExceptions
use Rack::Lint
use Rack::Session::Cookie,
		:key => 'rack.session',
		:secret => 'some_secret'

run RockPaperScissors::App.new

