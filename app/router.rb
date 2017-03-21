class Router < Sinatra::Base

  get '/' do
    "Hello World"
  end

  post '/alumno' do
    @json = JSON.parse(request.body.read)
    @matricula = @json["clave"]
    @password = @json["password"]

    nav = Navegador.new(@matricula, @password)
    #if nav.login then
      
    # Modelos con sinatra
    # http://stackoverflow.com/questions/22597989/how-to-define-a-class-in-ruby-when-using-sequel
  end
end
