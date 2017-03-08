require 'nokogiri'

class PeriodosParser
  def self.parsear(page)
    tablas = page.xpath("//table")
    parrafos = page.xpath("//p")

    informacion = tablas.shift
    info_mapa = informacion(informacion)

    periodos_arr = periodos(tablas, parrafos)
    periodos_mapa = {
      periodos: periodos_arr
    }
  end

  def informacion(tabla)
    rows = tabla.xpath("tr")
    programa_array = rows[1].xpath("td")[0].content.split
    programa = programa_array[1..-1].join(" ")

    campus_array = rows[1].xpath("td")[1].content.split
    campus = campus_array[1..-1].join(" ")
    mapa = {
      programa: programa,
      campus: campus
    }
    mapa
  end

  def periodo(tablas, parrafos, acumulador = [], pila = [])
    if !t.empty? then parciales = parciales(tablas.pop, acumulador) else return pila end

    tipo = parrafos.pop.content
    if p.last.include?("Periodo") then 
      periodo = parrafos.pop.content 
      periodo_mapa = get_mapa(periodo, tipo, parciales, acumulador.pop)
      pila << periodo_mapa
      periodo(tablas, parrafos, acumulador, pila)
    else
      acumulador << parciales
      periodo(tablas, parrafos, acumulador, pila)
    end
  end
end
