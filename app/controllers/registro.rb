require 'sinatra/activerecord'
require_relative "#{Dir.pwd}/app/helpers/token_helper.rb"
Dir["#{Dir.pwd}/app/modelos/*.rb"].each { |file| require file }

module RegistroController
  module_function

  def registrar_usuario(matricula)
    usuario = Usuario.find_by(matricula: matricula)
    if usuario == nil then
      Usuario.create(:matricula => matricula)
    end
    token = TokenHelper.create_custom_token(matricula)
    token
  end

end
