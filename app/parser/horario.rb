require 'nokogiri'

class HorarioParser

  def self.parsear(table)
    horario = []
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
    def materia(materia)
      clases = []
      nombre = materia[1]
      # grupo = if !materia[8].empty? then materia[8] else nil end
      # salon = if !materia[9].empty? then materia[9] else nil end
      profesor = materia[10]
      horas = materia[2..7]
      horas.each_with_index do |h, i|
        clases << clase(i+1,h,nombre,profesor) if h != "00-00"
      end
      clases
    end

    def clase(dia, horas, materia, profesor)
      divididas = horas.split("-")
      estructura = {
        dia: dia,
        hora_inicio: divididas[0],
        hora_final: divididas[1],
        materia: materia,
        profesor: profesor
      }
      estructura
    end
end
