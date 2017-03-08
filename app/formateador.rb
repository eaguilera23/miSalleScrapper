class Formateador

  def initialize
  end

  def ejemplo
    ejemplo = {
      usuario: {
        clave: 00060567,
        password: "Eao60567"
      },
      nombre: "Eduardo Aguilera",
      matricula: 60567,
      programa: "Las torres",
      campus: "La Salle",
      creditos: [{
        tipo: "solidaridad",
        cantidad: 8
      },
      {
        tipo: "deportivo",
        cantidad: 9
      }],
      periodos: [
        {
          mes_inicio: "AGO",
          mes_final: "JUN",
          year: 1996,
          boletas: [
            {
              tipo: "ORDINARIO",
              materia: "mate",
              profesor: {
                nombre: "Luis",
                apellidos: "Vazquez"
              },
              parciales: [
                {
                  numero: 1,
                  calificacion: 7.5
                },
                {
                  numero: 2,
                  calificacion: 8.3
                }
              ]
            }
          ]
        }
      ],
      clases: [
        {
          dia: 1,
          hora_inicio: 14,
          hora_final: 16,
          materia: "mate",
          profesor: {
            nombre: "Luis",
            apellidos: "Vazquez"
          }
        }
      ],
      faltas: [
        {
          materia: "mate",
          periodo: {
            mes_inicio: "AGO",
            mes_final: "JUN",
            year: 1996
          }
        }
      ]
    }
    ejemplo
  end
end
