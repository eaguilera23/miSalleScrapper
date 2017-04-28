module ErrorHelper
  module_function

  def login
    error = {codigo: 420, mensaje: "La matricula y/o contraseña son incorrectas."}
    error
  end
end
