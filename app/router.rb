require 'json'
require_relative 'formateador'
require_relative 'helpers/error_helper'
class Router < Sinatra::Base
  set :server, 'webrick'

  get '/' do
    "Hello World"
  end

  # Modelos con sinatra
  # http://stackoverflow.com/questions/22597989/how-to-define-a-class-in-ruby-when-using-sequel

  post '/alumno' do
    @json = JSON.parse(request.body.read)
    @matricula = @json["matricula"]
    @password = @json["password"]

    nav = Navegador.new(@matricula, @password)
    if nav.login then
      info = nav.parsear
      content_type :json, :charset => 'utf-8'
      info.to_json
    else
      status 420
      ErrorHelper.login.to_json
    end
  end

  ###################################
  # RUTAS PARA FACILITAR DESARROLLO #
  ###################################
  
  get '/alumno' do
    @matricula = params["matricula"]
    @password = params["password"]

    nav = Navegador.new(@matricula, @password)
    if nav.login then
      info = nav.parsear
      content_type :json, :charset => 'utf-8'
      info.to_json
    else
      status 420
      ErrorHelper.login.to_json
    end
  end

  get '/test' do
    @matricula = params["matricula"]
    @password = "jaja"

    nav = Navegador.new(@matricula, @password)
    info = nav.parsear
    content_type :json, :charset => 'utf-8'
    info.to_json
  end

  get '/ejemplo' do
    content_type :json, :charset => 'utf-8'
    JSON[Formateador.ejemplo]
  end
end
