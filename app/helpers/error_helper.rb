module ErrorHelper
  module_function

  def login
    error = {codigo: 420, mensaje: "La matricula y/o contraseña son incorrectas."}
    error
  end

  def feedback
    error = {codigo: 470, mensaje: "No se pudo entregar el feedback"}
    error
  end
end
