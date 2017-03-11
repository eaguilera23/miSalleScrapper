require 'nokogiri'

class CreditosParser
  
  def self.parsear(page)
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

  def self.get_mapa(arreglo)
    mapa = {
      tipo: arreglo[0].capitalize,
      necesarios: arreglo[4].to_i,
      actuales: arreglo[2].to_i
    }
    mapa
  end
end
