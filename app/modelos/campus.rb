class Campus < ActiveRecord::Base
  enum sistema: { licenciatura_campestre: 1,
                  profesional_campestre: 4,
                  especialidad_campestre: 5,
                  maestria_campestre: 6,
                  alonso_torres: 43,
                  americas: 33,
                  licenciatura1_salamanca: 20,
                  licenciatura2_salamanca: 21,
                  preparatoria_salamanca: 23,
                  especialidad_salamanca: 25,
                  maestria_salamanca: 26,
                  secundaria_sf: 12,
                  preparatoria_sf: 13
                }
  self.table_name = "campus"

  has_many :usuarios
end
