require 'rack/request'
require 'rack/response'
require 'haml'
require 'rack'

module RockPaperScissors
    class App 
  
      def initialize(app = nil)
        @app = app
        @content_type = :html
        @defeat = {'rock' => 'scissors', 'paper' => 'rock', 'scissors' => 'paper'}
        @throws = @defeat.keys
        @choose = @throws.map { |x| 
           %Q{ <li><a href="/?choice=#{x}">#{x}</a></li> }     #Puedes meter en haml con %li
        }.join("\n")
        @choose = "<p>\n<ul>\n#{@choose}\n</ul>\n</p>"				#Puedes añadir en haml con %p 
      end

			def set_env(env)
				@env = env
				@session = env['rack.session']
			end

			def getwin
				return @session['won'].to_i if @session['won']
				@session['won'] = 0
			end

			def setwin=(value)
				@session['won'] = value
			end

			def getlose
				return @session['lost'].to_i if @session['lost']
				@session['lost'] = 0
			end

			def setlose=(value)
				@session['lost'] = value
			end

			def gettie
				return @session['tied'].to_i if @session['tied']
				@session['tied'] = 0
			end

			def settie=(value)
				@session['tied'] = value
			end

			def getplay
				return @session['play'].to_i if @session['play']
				@session['play'] = 0
			end

			def setplay=(value)
				@session['play'] = value
			end

      def call(env)
				
				set_env(env)
        req = Rack::Request.new(env)
			  
				p "********************************************"
        p "Los parametros pasados por get o post son..."
				p req.params
				p "********************************************"
  
        req.env.keys.sort.each { |x| puts "#{x} => #{req.env[x]}" }
  
        computer_throw = @throws.sample
        player_throw = req.GET["choice"]
        answer = if !@throws.include?(player_throw)
            ""
          elsif player_throw == computer_throw
						
						self.setplay=self.getplay+1
						self.settie=self.gettie+1
            "Result: You tied with the computer"
						
          elsif computer_throw == @defeat[player_throw]
            
						self.setplay=self.getplay+1
						self.setwin=self.getwin+1
						"Result: Nicely done; #{player_throw} beats #{computer_throw}"
						
          else
						
						self.setplay=self.getplay+1
						self.setlose=self.getlose+1
            "Result: Ouch; #{computer_throw} beats #{player_throw}. Better luck next time!"
						
          end

        engine = Haml::Engine.new File.open("views/index.haml").read  
        res = Rack::Response.new

        res.write engine.render({},
          :answer => answer,
          :choose => @choose,
					:win => self.getwin,
					:lose => self.getlose,
					:tie => self.gettie,
					:play => self.getplay,
          :throws => @throws,
          :computer_throw => computer_throw,
          #:player_throw => player_throw,
          #:aux => aux
        )
        res.finish 
      end # call
    end   # App
  end     # RockPaperScissors

#  if $0 == __FILE__
#    require 'rack/showexceptions'
#    Rack::Server.start(
#      :app => Rack::ShowExceptions.new(
#                Rack::Lint.new(
#                  RockPaperScissors::App.new)),
#      :Port => 9292,
#      :server => 'thin'
#    )
#  end
