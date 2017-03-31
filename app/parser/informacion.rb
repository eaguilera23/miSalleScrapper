require_relative '../formateador'

module Parser
  module Informacion
    module_function
    #   *Módulo*
    # Este módulo se encarga de parsear la página que muestra la información del alumno
    # Url de la página: http://207.249.157.32/cgi-bin/r.cgi/Consulta/w0400701.r?sistema=X&matricula=XXXXX

    # Este método obtiene de la página la información escencial del alumno. Que es:
    # - Apellido Paterno
    # - Apellido Materno
    # - Nombre
    # - Sexo
    # - Email 
    # * *Argumentos*  :
    #   - +pagina+ -> Pagina que contiene la informacíon del alumno
    # * *Retorna*     :
    #   - +mapa+ -> Mapa con la información formateada del alumno. Para saber su estructura, consultar self.get_mapa
    def self.parsear(pagina)
      tabla = pagina.xpath("//table")[0]
      rows = tabla.xpath("tr")
      apellido_p = get_dato(rows[1].content, "Ap. Paterno:")
      apellido_m = get_dato(rows[2].content, "Ap. Materno:")
      nombre = get_dato(rows[3].content, "Nombre:")
      sexo = get_dato(rows[4].content, "Sexo:")
      email = get_dato(rows[7].content, "e-mail:")
      mapa = get_mapa(apellido_p, apellido_m, nombre, sexo, email)
      mapa
    end

    def self.get_dato(dato, quitar)
      dato.slice! quitar
      dato.strip
    end

    def self.get_mapa(ap, am, nombre, sexo, email)
      mapa = {
        # La informacion al parecer está guardada en La Salle con encoding cp1252,
        # pero Nokogiri la toma como utf-8. 
        nombre: Formateador::Texto.acentos(nombre.force_encoding("cp1252").encode("utf-8")),
        apellido_p: Formateador::Texto.acentos(ap.force_encoding("cp1252").encode("utf-8")),
        apellido_m: Formateador::Texto.acentos(am),
        sexo: sexo,
        email: email
      }
      mapa
    end
  end
end
