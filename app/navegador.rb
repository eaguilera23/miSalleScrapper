require 'mechanize'
require_relative 'parser/horario'
require_relative 'parser/periodos'
require_relative 'parser/creditos'
require_relative 'parser/informacion'
require_relative 'formateador'

class Navegador

  @@url
  @@pag_principal
  @@pag_horario
  @@pag_periodos
  @@pag_creditos
  @@pag_informacion
  @@matricula
  @@password

  @@url_terminacion

  @@agent

  def initialize(matricula, password)
    @@url = "http://207.249.157.32/cgi-bin/r.cgi/Consulta/"
    @@url_principal = "principal.r"
    @@url_terminacion = "?sistema=1&matricula="
    @@pag_principal = "w0400501.r"
    @@pag_horario = "w0400501.r"
    @@pag_periodos = "w0400301.r"
    @@pag_creditos = "w0600101.r"
    @@pag_informacion = "w0400701.r"
    @@matricula = matricula.to_s
    @@password = password.to_s

    @@agent = Mechanize.new
    @@agent.user_agent_alias = 'Mac Safari'
  end


  def login
    page = @@agent.get(@@url + @@url_principal)
    form = page.form('form1')
    page = @@agent.submit(form)

    form = page.form('form1')
    form.matricula = @@matricula
    form.nip = @@password
    page = @@agent.submit(form)
    if page.css(".errormensaje").count < 1 then
      return true
    else
      return false
    end
    # Como unir todos los jsons:
    # http://stackoverflow.com/questions/13990523/how-to-append-json-objects-together-in-ruby
  end

  def parsear
    horario = self.horario
    periodos, faltas, info_map = self.periodos
    creditos = self.creditos
    informacion = self.informacion
    mapa = Formateador::Alumno.formatear(@@matricula, @@password, info_map, informacion, horario, periodos, faltas, creditos)
    mapa
  end

  def horario
    url = get_url(@@pag_horario)
    page = @@agent.get(url)
    clases = Parser::Horario.parsear(page)
    clases
  end

  def periodos
    url = get_url(@@pag_periodos)
    page = @@agent.get(url)
    periodos_arr, faltas_arr, info_map = Parser::Periodos.parsear(page)
    return periodos_arr, faltas_arr, info_map
  end

  def creditos
    url = get_url(@@pag_creditos)
    page = @@agent.get(url)
    creditos = Parser::Creditos.parsear(page)
    creditos
  end

  def informacion
    url = get_url(@@pag_informacion)
    page = @@agent.get(url)
    informacion = Parser::Informacion.parsear(page)
    informacion
  end

  ##############
  # DESARROLLO #
  ##############
  def self.new_matricula(matricula)
    self.new(matricula, "Password01")
  end

private
    def get_url(pag)
      @@url + pag + @@url_terminacion + @@matricula
    end
end
