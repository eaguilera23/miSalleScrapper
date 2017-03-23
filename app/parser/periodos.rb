require 'nokogiri'
require_relative '../formateador'

class PeriodosParser
  def self.get_informacion(tabla)
    rows = tabla.xpath("tr")
    programa_array = rows[1].xpath("td")[0].content.split
    programa = programa_array[1..-1].join(" ")

    campus_array = rows[1].xpath("td")[1].content.split
    campus = campus_array[1..-1].join(" ")
    mapa = {
      programa: programa.capitalize,
      campus: campus.capitalize
    }
    mapa
  end

  def self.periodos(tablas, parrafos, acumulador = [], pila = [], faltas = [])
    if !tablas.empty? then boletas, faltas_arr = self.boletas(tablas.pop, parrafos.pop, acumulador) else return pila, faltas end

    if parrafos.last.content.include?('Periodo') then 
      periodo = get_periodo(parrafos.pop.content)
      periodo_mapa = get_mapa(periodo, boletas)
      pila << periodo_mapa
      faltas_final = set_periodos_faltas(faltas_arr, periodo_mapa)
      faltas.concat(faltas_final)

      periodos(tablas, parrafos, acumulador, pila, faltas)
    else
      acumulador << boletas
      periodos(tablas, parrafos, acumulador, pila, faltas)
    end
  end

  def self.set_periodos_faltas(faltas_arr, periodo_mapa)
    faltas_arr.each do |f|
      f[:periodo] = {
        mes_inicio: periodo_mapa[:mes_inicio],
        mes_final: periodo_mapa[:mes_final],
        year: periodo_mapa[:year]
      }
    end 
    faltas_arr
  end

  def self.get_mapa(periodo, boletas)
    mapa = {
      mes_inicio: periodo[:mes_inicio],
      mes_final: periodo[:mes_final],
      year: periodo[:year],
      boletas: boletas
    }
    mapa
  end

  def self.boletas(tabla, parrafo,  acumulador)
    tipo = parrafo.content
    boletas = []
    faltas = []

    rows = tabla.xpath("tr") 
    boletas_rows = rows[2..-4]
    boletas_rows.each_with_index do |b, i|
      if i.even? then
        celdas = b.xpath("td")
        nom_materia = celdas[1].content.strip
        profesor = celdas[-1].content.strip
        parcial1 = celdas[4].content.strip
        parcial2 = celdas[6].content.strip
        parcial3 = celdas[8].content.strip
        parcial4 = celdas[10].content.strip
        falta = get_faltas(celdas[11].content.strip, nom_materia)
        final = celdas[12].content.strip
        mapa = {
          tipo: tipo,
          materia: Formateador.string(nom_materia.force_encoding("cp1252")),
          profesor: Formateador.string(profesor),
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
       faltas << falta
      end
    end
    boletas << acumulador.last.pop unless acumulador.empty?
    return boletas, faltas
  end

  def self.get_faltas(faltas, nom_materia)
    mapa = {
      cantidad: faltas,
      materia: Formateador.string(nom_materia.force_encoding("cp1252"))
    }
    mapa
  end

  def self.parsear(page)
    tablas = page.xpath("//table")
    parrafos = page.xpath("//p")[1..-6]

    info = tablas.shift
    info_mapa = self.get_informacion(info)

    periodos_arr, faltas_arr = self.periodos(tablas, parrafos)
    return periodos_arr, faltas_arr, info_mapa
  end

  def self.get_periodo(periodo)
    arr = periodo.split
    mes_inicio = get_mes_num(arr[1].strip)
    mes_final = get_mes_num(arr[3].strip)
    year = arr[4].to_i
    map = {
      mes_inicio: mes_inicio,
      mes_final: mes_final,
      year: year
    }
    map
  end

  def self.get_mes_num(mes)
    case mes
    when "AGO"
      return 8
    when "DIC"
      return 12
    when "FEB"
      return 2
    when "JUN"
      return 6
    when "ENE"
      return 1
    when "MAR"
      return 3
    when "ABR"
      return 4
    when "MAY"
      return 5
    when "JUL"
      return 7
    when "SEP"
      return 9
    when "OCT"
      return 10
    when "NOV"
      return 11
    else
      return 0
    end
  end
end
