require 'json'
require 'sinatra/base'
require 'sinatra/activerecord'
require_relative 'formateador'
require_relative 'helpers/error_helper'
require_relative 'helpers/login_helper'
Dir["#{Dir.pwd}/app/modelos/*.rb"].each { |file| require file }

class Router < Sinatra::Base
  register Sinatra::ActiveRecordExtension
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

    if LoginHelper.check_params(@matricula, @password) then
      nav = Navegador.new(@matricula, @password)
      if nav.login then
        @usuario = Usuario.create(:matricula => @matricula)
        info = nav.parsear
        content_type :json, :charset => 'utf-8'
        info.to_json
      else
        status 420
        ErrorHelper.login.to_json
      end
    else
      status 420
      ErrorHelper.login.to_json
    end
  end

  post '/creditos' do
    @json = JSON.parse(request.body.read)
    @matricula = @json["matricula"].to_i.to_s
    @password = @json["password"]

    if LoginHelper.check_params(@matricula, @password) then
      nav = Navegador.new(@matricula, @password)
      if nav.login then
        creditos = nav.creditos
        info = Formateador::Creditos.formatear(creditos)
        content_type :json, :charset => 'utf-8'
        info.to_json
      else
        status 420
        ErrorHelper.login.to_json
      end
    else
      status 420
      ErrorHelper.login_to_json
    end
  end

  post '/periodos' do
    @json = JSON.parse(request.body.read)
    @matricula = @json["matricula"].to_i.to_s
    @password = @json["password"]

    if LoginHelper.check_params(@matricula, @params) then
      nav = Navegador.new(@matricula, @password)
      if nav.login then
        periodos, info_map = nav.periodos
        info = Formateador::Periodos.formatear(periodos) 
        content_type :json, :charset => 'utf-8'
        info.to_json
      else
        status 420
        ErrorHelper.login.to_json
      end
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
    if @matricula === "0" then
      @matricula = ""
    end

    if @matricula.empty? or @password.empty? then
      status 420
      ErrorHelper.login.to_json
    else
      nav = Navegador.new(@matricula, @password)
      if nav.login then
        @usuario = Usuario.create(:matricula => @matricula)
        info = nav.parsear
        content_type :json, :charset => 'utf-8'
        info.to_json
      else
        status 420
        ErrorHelper.login.to_json
      end
    end
  end

  get '/creditos' do
    @matricula = params["matricula"].to_i.to_s
    @password = params["password"]
    if @matricula === "0" then
      @matricula = ""
    end

    if @matricula.empty? or @password.empty? then
      status 420
      ErrorHelper.login.to_json
    else
      nav = Navegador.new(@matricula, @password)
      if nav.login then
        creditos = nav.creditos
        info = Formateador::Creditos.formatear(creditos)
        content_type :json, :charset => 'utf-8'
        info.to_json
      else
        status 420
        ErrorHelper.login.to_json
      end
    end
  end

  get '/periodos' do
    @matricula = params["matricula"].to_i.to_s
    @password = params["password"]

    if LoginHelper.check_params(@matricula, @password) then
      nav = Navegador.new(@matricula, @password)
      if nav.login then
        periodos, info_map = nav.periodos
        info = Formateador::Periodos.formatear(periodos) 
        content_type :json, :charset => 'utf-8'
        info.to_json
      else
        status 420
        ErrorHelper.login.to_json
      end
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

  get '/mihorario' do
    File.read("#{Dir.pwd}/app/example-horario.html")
  end

  post '/mihorario' do
    File.read("#{Dir.pwd}/app/example-horario.html")
  end
end
