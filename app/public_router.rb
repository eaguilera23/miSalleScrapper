require 'sinatra/base'

class PublicRouter < Sinatra::Base
  set :server, 'webrick'

  get '/' do
    redirect '/index.html'
  end

  post '/campus' do
    email = params["email"]


    if email != nil then
      existe = Interesado.find_by(email: email)
      if existe != nil then
        status 200
      else
        interesado = Interesado.new(email: email)
        if interesado.save then
          status 200
        end
      end
    else
      status 400
    end
  end

end
