require 'sinatra/base'

class PublicRouter < Sinatra::Base
  set :server, 'webrick'

  get '/' do
    redirect '/index.html'
  end

  post '/campus' do
    email = params["email"]

    if email != nil then
      existe = InteresadoCampus.find_by(email: email)
      if existe != nil then
        status 200
      else
        interesado = InteresadoCampus.new(email: email)
        if interesado.save then
          status 200
        end
      end
    else
      status 400
    end
  end

  post '/anuncio' do
    name = params["name"]
    company = params["company"]
    email = params["email"]
    package = params["package"]

    if name != nil or company != nil or email != nil or package != nil then
      package = package.to_i
      if InteresadoAnuncio.existe_paquete? package then
        interesado = InteresadoAnuncio.new(nombre: name, empresa: company, email: email, paquete: package)
        if interesado.save then
          status 200
        else
          status 400
        end
      else
        status 400
      end
    else
      status 400
    end
  end

end
