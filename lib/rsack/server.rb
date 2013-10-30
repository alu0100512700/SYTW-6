module Rsack
	class Server
		def initialize(app=nil)
			@app = app
		end
		
		def call(env)
			@app.call(env) if @app
		end
	end
end
