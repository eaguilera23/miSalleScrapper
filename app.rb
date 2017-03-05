require 'rubygems'
require 'mechanize'

# PAGINA PRINCIPAL
agent = Mechanize.new
agent.user_agent_alias = 'Mac Safari'

page = agent.get("http://207.249.157.32/cgi-bin/r.cgi/Consulta/principal.r")

form = page.form('form1')
page = agent.submit(form, form.buttons.first)

# LOGIN

form = page.form('form1')
form.matricula = '00060568'
form.nip = 'Eao60568'
page = agent.submit(form)

# pp page
puts page

## FORMATO DE JSON

