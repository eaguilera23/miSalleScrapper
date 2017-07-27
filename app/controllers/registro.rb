require 'sinatra/activerecord'
Dir["#{Dir.pwd}/app/modelos/*.rb"].each { |file| require file }

module RegistroController
  module_function

  def registrar_usuario(matricula)
    usuario = Usuario.find_by(matricula: matricula)
    if usuario == nil then
      Usuario.create(:matricula => matricula)
    end
  end

end
