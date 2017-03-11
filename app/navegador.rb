require 'mechanize'
require 'json'
require_relative 'parser/horario'
require_relative 'parser/periodos'
require_relative 'parser/creditos'

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
    @@pag_creditos = "w0600101.r"
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
    # temp
    horario
    # Como unir todos los jsons:
    # http://stackoverflow.com/questions/13990523/how-to-append-json-objects-together-in-ruby
  end

  def horario
    url = get_url(@@pag_horario)
    page = @@agent.get(url)

    # Tabla que contiene las horas de las clases
    table = page.xpath("//table")[2]
    # arreglo que contendra todas las clases
    clases = HorarioParser.parsear(table)
    clases
  end

  def periodos
    url = get_url(@@pag_periodos)
    page = @@agent.get(url)
    periodos_arr, faltas_arr = PeriodosParser.parsear(page)
    return periodos_arr, faltas_arr
  end

  def creditos
    url = get_url(@@pag_creditos)
    page = @@agent.get(url)
    creditos = CreditosParser.parsear(page)
    creditos
  end

private
    def get_url(pag)
      @@url + pag + @@url_terminacion + @@matricula
    end
end
