require 'mechanize'
require_relative 'parser/horario'

class Navegador

  @@url
  @@pag_principal
  @@pag_horario
  @@pag_periodos
  @@pag_creditos
  @@matricula

  @@url_terminacion

  @@agent

  def initialize(matricula)

    @@url = "http://207.249.157.32/cgi-bin/r.cgi/Consulta/"
    @@url_principal = "principal.r"
    @@url_terminacion = "?sistema=1&matricula="
    @@pag_principal = "w0400501.r"
    @@pag_horario = "w0400501.r"
    @@pag_periodos = "w0400301.r"
    @@pag_creditos = "w600101.r"
    @@matricula = matricula.to_s

    @@agent = Mechanize.new
    @@agent.user_agent_alias = 'Mac Safari'
  end

  def login(params)
    page = @@agent.get(@@url + @@url_principal)
    form = page.form('form1')
    page = @@agent.submit(form)

    form = page.form('form1')
    form.matricula = params[:clave]
    form.nip = params[:password]
    page = @@agent.submit(form)
    menu = page.frames[1].click
    horario
  end

  def horario
    url = @@url + @@pag_horario + @@url_terminacion + @@matricula
    page = @@agent.get(url)

    # Tabla que contiene las horas de las clases
    table = page.xpath("//table")[2]
    # arreglo que contendra todas las clases
    clases = HorarioParser.parsear(table)
    clases
  end
end
