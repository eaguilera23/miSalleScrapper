require 'sinatra/activerecord'
Dir["#{Dir.pwd}/app/modelos/*.rb"].each { |file| require file }

module RegistroController
  module_function

  def registrar_usuario(matricula, sistema)
    usuario = Usuario.find_by(matricula: matricula)
    nuevo_ingreso = false
    if usuario == nil then
      campus = Campus.find_by(sistema: sistema)
      Usuario.create(:matricula => matricula, :campus => campus)
      nuevo_ingreso = true
    end

    nuevo_ingreso
  end
end
