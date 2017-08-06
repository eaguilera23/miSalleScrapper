module LoginHelper
  module_function
  
  def check_params(p_matricula, p_password, p_sistema)
    matricula = p_matricula == "0" ? "" : p_matricula    
    return !(matricula.empty? or p_password.empty? or p_sistema == nil or p_sistema == 0)
  end
end
