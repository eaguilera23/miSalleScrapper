require 'sinatra/base'

class PublicRouter < Sinatra::Base
  set :server, 'webrick'

  get '/' do
    redirect '/index.html'
  end

end
