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
    @matricula = @json["matricula"].to_i.to_s
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

  post '/actualizar' do
    @json = JSON.parse(request.body.read)
    @matricula = @json["matricula"].to_i.to_s
    @password = @json["password"]

    nav = Navegador.new(@matricula, @password)
    if nav.login then
      info = nav.parsear_actualizar
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
    @matricula = params["matricula"].to_i.to_s
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

  get '/actualizar' do
    @matricula = params["matricula"].to_i.to_s
    @password = params["password"]

    nav = Navegador.new(@matricula, @password)
    if nav.login then
      info = nav.parsear_actualizar
      content_type :json, :charset => 'utf-8'
      info.to_json
    else
      status 420
      ErrorHelper.login.to_json
    end
  end

  get '/test' do
    @matricula = params["matricula"].to_i.to_s
    @password = "jaja"

    nav = Navegador.new_matricula(@matricula)
    info = nav.parsear
    content_type :json, :charset => 'utf-8'
    info.to_json
  end

  post '/test' do
    @json = JSON.parse(request.body.read)
    @matricula = @json["matricula"].to_i.to_s

    nav = Navegador.new_matricula(@matricula)
    info = nav.parsear
    content_type :json, :charset => 'utf-8'
    info.to_json
  end

  get '/ejemplo' do
    content_type :json, :charset => 'utf-8'
    JSON[Formateador.ejemplo]
  end
end
