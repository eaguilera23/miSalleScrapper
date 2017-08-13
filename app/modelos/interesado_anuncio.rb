class InteresadoAnuncio < ActiveRecord::Base
  self.table_name = "interesado_anuncio"
  enum paquete: [:basico, :estandard, :personalizado]

  def self.existe_paquete?(paquete)
    return self.defined_enums["paquete"].keys.count > paquete && paquete >= 0 
  end
end
