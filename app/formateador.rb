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

    module V1
      module_function

      def formatear(mapa)
        mapa = {
          matricula: mapa[:matricula],
          nombre: mapa[:informacion][:nombre],
          apellido_p: mapa[:informacion][:apellido_p],
          apellido_m: mapa[:informacion][:apellido_m],
          usuario: {
            matricula: mapa[:matricula],
            password: mapa[:password]
          },
          campus: {nombre: mapa[:info_map][:campus]},
          programa: {nombre: mapa[:info_map][:programa]},
          creditos: mapa[:creditos],
          clases: mapa[:horario],
          periodos: mapa[:periodos]
        }
        mapa
      end
    end
  end

  module Creditos
    module_function
    
    module V1
      module_function
      def formatear(creditos)
        mapa = {
          creditos: creditos
        }
        mapa
      end 
    end
  end

  module Periodos
    module_function
    module V1
      module_function
      def formatear(periodos)
        mapa = {
          periodos: periodos
        }
        mapa
      end
    end
  end

  module Anuncio
    module_function

    module V1
      module_function
    
      def formatear(campaign)
        mapa = {
          campaign_id: campaign.id,
          destino_click: campaign.destino_click,
          ruta_imagen: campaign.anuncio.ruta_imagen
        }

        mapa
      end
    end
  end

  module Pagos
    module_function
    module V1
      module_function
    
      def formatear(pagos)
        arreglo = []
        pagos.each do |p|
           pago = {
            mes: p.fecha.month,
            year: p.fecha.year,
            dia: p.fecha.day
           }
           arreglo << pago
        end
        arreglo
      end
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
