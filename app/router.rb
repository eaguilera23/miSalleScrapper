require 'json'
class Router < Sinatra::Base

  get '/' do
    "Hello World"
  end

  #post '/alumno' do
  get '/alumno' do
    #@json = JSON.parse(request.body.read)
    #@matricula = @json["clave"]
    #@password = @json["password"]
    @matricula = params["clave"]
    @password = params["password"]

    nav = Navegador.new(@matricula, @password)
    if nav.login then
      info = nav.parsear
      content_type :json
      info.to_json
    else
      "No man"
    end
    # Modelos con sinatra
    # http://stackoverflow.com/questions/22597989/how-to-define-a-class-in-ruby-when-using-sequel
  end
end
