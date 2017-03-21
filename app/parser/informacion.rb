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
      nombre: nombre,
      apellido_p: ap,
      apellido_m: am,
      sexo: sexo,
      email: email
    }
    mapa
  end
end
