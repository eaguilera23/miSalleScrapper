require 'nokogiri'
require_relative '../formateador'

class HorarioParser
  #   *Módulo*
  # Este módulo se encarga de parsear la página que muestra el horario de un alumno
  # Url de la página: http://207.249.157.32/cgi-bin/r.cgi/Consulta/w0400501.r?sistema=X&matricula=XXXXX

  # Este método recorre la tabla del horario para interacturar con cada materia
  # * *Argumentos*  :
  #   - *table* -> La tabla que contiene el horario del alumno
  # * *Retorna*     :
  #   - *horario* -> Un arreglo con todas las clases obtenidas. Para ver el mapa que retorna,
  #                  revisar el método self.clase
  def self.parsear(page)
    horario = []
    table = page.xpath("//table")[2]
    table.xpath('tr').each_with_index do |tr, i|
      # i = 0 son las cabeceras. A partir de ahi son las clases
      unless i == 0
        cont = tr.content.split("\n")
        horario += materia(cont)
      end
    end
    horario
  end

private
    def self.materia(materia)
      clases = []
      nombre = materia[1].capitalize
      # grupo = if !materia[8].empty? then materia[8] else nil end
      # salon = if !materia[9].empty? then materia[9] else nil end
      profesor = materia[10]
      horas = materia[2..7]
      horas.each_with_index do |h, i|
        clases << clase(i+1,h,nombre,profesor) if h != "00-00"
      end
      clases
    end

    def self.clase(dia, horas, materia, profesor)
      divididas = horas.split("-")
      estructura = {
        dia: dia,
        hora_inicio: divididas[0].to_i,
        hora_final: divididas[1].to_i,
        materia: Formateador.string(materia),
        profesor: Formateador.string(profesor)
      }
      estructura
    end
end
