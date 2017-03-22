class Formateador

  def self.formatear(matricula, clave, info_map, informacion, horario, periodos, faltas, creditos)
    mapa = {
      usuario: {
        matricula: matricula,
        clave: clave
      },
      nombre: informacion[:nombre],
      apellido_p: informacion[:apellido_p],
      apellido_m: informacion[:apellido_m],
      sexo: informacion[:sexo],
      email: informacion[:email],
      matricula: matricula,
      programa: info_map[:programa],
      campus: info_map[:campus],
      creditos: creditos,
      periodos: periodos,
      horario: horario,
      faltas: faltas
    }
    mapa
  end

  def self.ejemplo
    ejemplo = {
      usuario: {
        matricula: 00060567,
        password: "JPJ60567"
      },
      nombre: "Jesús",
      apellido_p: "Perez",
      apellido_m: "Jimenez",
      matricula: 60567,
      programa: "Carrera",
      campus: "Torres",
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
              materia: "mate",
              profesor: "Enrique Perez Perez",
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
      horario: [
        {
          dia: 1,
          hora_inicio: 14,
          hora_final: 16,
          materia: "mate",
          profesor: "Pepe Perez Gonzales"
        }
      ],
      faltas: [
        {
          materia: "mate",
          cantidad: 3,
          periodo: {
            mes_inicio: 8,
            mes_final: 12,
            year: 1996
          }
        }
      ]
    }
    ejemplo
  end
end
