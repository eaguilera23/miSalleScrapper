require 'nokogiri'
require 'pry'

class PeriodosParser
  def self.get_informacion(tabla)
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

  def self.periodos(tablas, parrafos, acumulador = [], pila = [])
    if !tablas.empty? then boletas = self.boletas(tablas.pop, parrafos.pop, acumulador) else return pila end

    if parrafos.last.content.include?('Periodo') then 
      periodo = parrafos.pop.content 
      periodo_mapa = get_mapa(periodo, boletas)
      pila << periodo_mapa
      periodos(tablas, parrafos, acumulador, pila)
    else
      acumulador << boletas
      periodos(tablas, parrafos, acumulador, pila)
    end
  end

  def self.get_mapa(periodo, boletas)
    mapa = {
      periodo: periodo,
      boletas: boletas
    }
    mapa
  end

  def self.boletas(tabla, parrafo,  acumulador)
    tipo = parrafo.content
    boletas = []

    rows = tabla.xpath("tr") 
    boletas_rows = rows[2..-4]
    boletas_rows.each_with_index do |b, i|
      if i.even? then
        celdas = b.xpath("td")
        nom_materia = celdas[1].content
        profesor = celdas[-1].content
        parcial1 = celdas[4].content.strip
        parcial2 = celdas[6].content.strip
        parcial3 = celdas[8].content.strip
        parcial4 = celdas[10].content.strip
        # faltas = celdas[11].content.strip
        final = celdas[12].content.strip
        mapa = {
          tipo: tipo,
          materia: nom_materia,
          profesor: profesor,
          parciales: [
            {
              numero: 1,
              calificacion: parcial1
            },
            {
              numero: 2,
              calificacion: parcial2
            },
            {
              numero: 3,
              calificacion: parcial3
            },
            {
              numero: 4,
              calificacion: parcial4
            },
            {
              # Calificacion Final
              numero: 5,
              calificacion: final
            }
          ]
        }
       boletas << mapa 
      end
    end
    boletas << acumulador.last.pop unless acumulador.empty?
    boletas
  end

  def self.parsear(page)
    tablas = page.xpath("//table")
    parrafos = page.xpath("//p")[1..-6]

    info = tablas.shift
    info_mapa = self.get_informacion(info)

    periodos_arr = self.periodos(tablas, parrafos)
    periodos_arr
  end
end
