require 'nokogiri'

module Parser
  module Creditos
    module_function
    #   *Módulo* 
    # Este módulo se encarga de parsear la página que muestra los créditos de un alumno
    # Url de la página: http://207.249.157.32/cgi-bin/r.cgi/Consulta/w0600101.r?sistema=1&matricula=XXXXX
    
    # Este método contiene toda la lógica para obtener los créditos
    # * *Argumentos*  :
    #   - *page* -> Una página que se puede parsear con Nokogiri
    # * *Retorna*   :
    #   - *creditos* -> Arreglo con la información de todos los créditos
    def parsear(page)
      tabla = page.xpath("//table")
      rows = tabla.xpath("tr")
      solidaridad_arr = rows[1].content.split
      cultural_arr = rows[2].content.split
      deportivos_arr = rows[3].content.split

      creditos = []
      creditos << get_mapa(solidaridad_arr)
      creditos << get_mapa(cultural_arr)
      creditos << get_mapa(deportivos_arr)
      creditos
    end

    def get_mapa(arreglo)
      mapa = {
        tipo: arreglo[0].capitalize,
        necesarios: arreglo[4].to_i,
        actuales: arreglo[2].to_i
      }
      mapa
    end
  end
end
