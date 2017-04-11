module Formateador
  module_function
  # Este módulo se encarga de darle formato a las estructuras que datos que el sistema utiliza
  module Alumno
    module_function

    # Se encarga de dar formato a la estructura de la información completa del alumno
    #
    # * *Argumentos*  :
    #   - +matricula+ -> La matricula del alumno
    #   - +password+ -> El password del alumno
    #   - +info_map+ -> Un mapa que contiene el programa y el campus del alumno, siendo:
    #     - programa
    #     - campus
    #   - +informacion+ -> Un mapa con la información personal del alumno, siendo: 
    #     - nombre
    #     - apellido_p
    #     - apellido_m
    #     - sexo
    #     - email
    #   - +horario+ -> Un arreglo con las clases del alumno
    #   - +periodos+ -> Un arreglo con los periodos del alumno
    #   - +faltas+ -> Un arreglo con las faltas del alumno
    #   - +creditos+ -> Un arreglo con los créditos del alumno
    # * *Retorna*     :
    #   - +mapa+ -> Un mapa con toda la informacion del alumno

    def formatear(matricula, password, info_map, informacion, horario, periodos, faltas, creditos)
      mapa = {
        alumno: {
          matricula: matricula,
          nombre: informacion[:nombre],
          usuario: {
            matricula: matricula,
            password: password
          },
          campus: {nombre: info_map[:campus]},
          programa: {nombre: info_map[:programa]},
          creditos: creditos,
          clases: horario,
          periodos: periodos,
          faltas: faltas
        }
      }
      mapa
    end
  end

  module Actualizar
    module_function
    def formatear(periodos, faltas, creditos)
      mapa = {
        periodos: periodos,
        faltas: faltas,
        creditos: creditos
      }
      mapa
    end
  end

  module Texto
    module_function
    # El sitio de la salle guarda diferentes textos en diferentes encodings.
    # Todavía no se sabe si es problema directamente de La Salle, o cómo Nokogiri
    # interactua con el sitio. Todo esto para representar correctamente los acentos.
    # * *Argumentos*  :
    #   - +string+ -> La cadena a revisar
    # * *Retorna*     :
    #   - +resultado+ -> Cadena correctamente formateada presentando cualquier caractér especial
    def acentos(string)
      resultado = ""
      if string.encoding.to_s == "UTF-8" then
        # puts "String a convertir: " + string + " con encoding: " + string.encoding.to_s
        resultado = string
        # puts "El resultado es: " + resultado + " con encoding: " + resultado.encoding.to_s
      elsif string.encoding.to_s == "Windows-1252"
        # puts "String a convertir: " + string + " con encoding: " + string.encoding.to_s
        resultado = string.force_encoding("utf-8")
        # puts "El resultado es: " + resultado + " con encoding: " + resultado.encoding.to_s
      else
        puts "El encoding es: " + string.encoding.to_s + " de: " + string
      end
      resultado
    end
  end

  ##############
  # DESARROLLO #
  ##############
  def ejemplo
   ejemplo = {
     alumno: {
       matricula: 60568,
       nombre: "Jesus",
       apellido_p: "Perez",
       apellido_m: "Jimenez",
       usuario: {
        matricula: 00060567,
        password: "JPJ60567"
       },
       campus: {nombre: "Las torres"},
       programa: {nombre: "Le Software"},
       creditos: [{
         tipo: "Solidaridad",
         necesarios: 30,
         actuales: 8
         },
         {
           tipo: "Deportivo",
           necesarios: 30,
           actuales: 9
         }],
      periodos: [
        {
          mes_inicio: 8,
          mes_final: 12,
          year: 2017,
          boletas: [
            {
              tipo: 1,
              materia: {nombre: "mate"},
              profesor: {nombre: "Enrique Perez Perez"},
              parciales: [
                {
                  numero: 1,
                  calificacion: 7.5
                },
                {
                  numero: 2,
                  calificacion: 8.3
                },
                {
                  numero: 3,
                  calificacion: 8.8
                },
                {
                  numero: 4,
                  calificacion: 8.4
                },
                {
                  numero: 5,
                  calificacion: 8.9
                },
              ]
            }
          ]
        }
      ],
      faltas: [
        {
          materia: {nombre: "mate"},
          cantidad: 3,
          periodo: {
            mes_inicio: 8,
            mes_final: 12,
            year: 1996
          }
        }
      ]
     }
   } 
    ejemplo
  end
end
