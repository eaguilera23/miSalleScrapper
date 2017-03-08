class Router < Sinatra::Base

  get '/' do
    @clave = params["clave"]
    @password = params["password"]
    "Hello World"
  end
end
