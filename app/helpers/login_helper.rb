module LoginHelper
  module_function
  
  def check_params(p_matricula, p_password)
    matricula = p_matricula == "0" ? "" : p_matricula    
    if matricula.empty? or p_password.empty? then
      return false
    else
     return true
    end 
  end
end
