require_relative '../formateador'
class InformacionParser

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
      nombre: Formateador.string(nombre.force_encoding("cp1252").encode("utf-8")),
      apellido_p: Formateador.string(ap.force_encoding("cp1252").encode("utf-8")),
      apellido_m: Formateador.string(am),
      sexo: sexo,
      email: email
    }
    mapa
  end
end
