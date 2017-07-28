require 'mechanize'
require_relative 'parser/horario'
require_relative 'parser/periodos'
require_relative 'parser/creditos'
require_relative 'parser/informacion'
require_relative 'formateador'

class Navegador

  @@url
  @@url_login
  @@pag_principal
  @@pag_horario
  @@pag_periodos
  @@pag_creditos
  @@pag_informacion
  @@matricula
  @@password
  @@pag_encoding

  @@url_terminacion

  @@agent

  def initialize(matricula, password)
    @@url = "http://207.249.157.32/cgi-bin/r.cgi/Consulta/"
    @@url_login = "http://bajio.delasalle.edu.mx/login.php"
    @@url_principal = "principal.r"
    @@url_terminacion = "?sistema=1&matricula="
    @@pag_principal = "w0400501.r"
    @@pag_horario = "w0400501.r"
    @@pag_periodos = "w0400301.r"
    @@pag_creditos = "w0600101.r"
    @@pag_informacion = "w0400701.r"
    @@pag_encoding = "cp1252"
    @@matricula = matricula.to_s
    @@password = password.to_s

    @@agent = Mechanize.new
    @@agent.user_agent_alias = 'Mac Safari'
    @@agent.follow_meta_refresh = true
  end


  def login
    page = @@agent.get(@@url_login)

    form = page.form(:id => 'frmLogin')
    form.txtUsuario = matricula_con_ceros(@@matricula)
    form.txtPass = @@password
    login_page = @@agent.submit(form, form.buttons.first)
    if login_page.css(".error").count < 1 then
      return true
    else
      return false
    end
  end

  def parsear
    horario = self.horario
    periodos, info_map = self.periodos
    creditos = self.creditos
    informacion = self.informacion
    mapa = {
      matricula: @@matricula,
      password: @@password,
      info_map: info_map,
      informacion: informacion,
      horario: horario,
      periodos: periodos,
      creditos: creditos
    }
    mapa
  end

  def horario
    #url = get_url(@@pag_horario)
    #page = @@agent.get(url)
    
    page = @@agent.get("http://pruebatarea2302.herokuapp.com/api/v1/mihorario")

    page.encoding = @@pag_encoding
    clases = Parser::Horario.parsear(page)
    clases
  end

  def periodos
    url = get_url(@@pag_periodos)
    page = @@agent.get(url)
    page.encoding = @@pag_encoding
    periodos_arr, info_map = Parser::Periodos.parsear(page)
    return periodos_arr, info_map
  end

  def creditos
    url = get_url(@@pag_creditos)
    page = @@agent.get(url)
    page.encoding = @@pag_encoding
    creditos = Parser::Creditos.parsear(page)
    creditos
  end

  def informacion
    url = get_url(@@pag_informacion)
    page = @@agent.get(url)
    page.encoding = @@pag_encoding
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

    def matricula_con_ceros(matricula)
      matricula_ceros = matricula.to_s
      while matricula_ceros.length < 8 do
        matricula_ceros = "0" + matricula_ceros
      end

      matricula_ceros
    end
end
