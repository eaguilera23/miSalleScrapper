require 'mechanize'

class Navegador

  @@url = ""
  @@agent

  def initialize
    @@url = "http://207.249.157.32/cgi-bin/r.cgi/Consulta/principal.r"
    @@agent = Mechanize.new
    @@agent.user_agent_alias = 'Mac Safari'
  end

  def login(params)
    page = @@agent.get(@@url)
    form = page.form('form1')
    page = @@agent.submit(form)

    form = page.form('form1')
    form.matricula = params[:clave]
    form.nip = params[:password]
    page = @@agent.submit(form)
    page
  end
end
