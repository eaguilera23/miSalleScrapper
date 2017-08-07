require_relative "#{Dir.pwd}/app/router_v1.rb"
Dir["#{Dir.pwd}/app/modelos/*.rb"].each { |file| require file }
module SetupHelper
  module_function

  def default
    self.publicidad()
    self.pagos()
    self.campus()
  end

  def publicidad
   anunciante = Anunciante.create(nombre: "Eduardo Aguilera Olascoaga", 
                                  telefono: "4774493833", 
                                  email: "laloao.2302@gmail.com", 
                                  empresa: "Monk Estudio de Desarrollo") 
   campaign = Campaign.new(status: :no_activo, 
                           vistas_contratadas: 100000, 
                           destino_click: "http://www.misalle.com.mx",
                           fecha_inicio: DateTime.now)
   anuncio = Anuncio.new(ruta_imagen: "https://s3.envato.com/files/62273611/PNG%20Blue/Banner%20blue%20320x50.png")
   anuncio.save
   campaign.anuncio = anuncio
   campaign.anunciante = anunciante
   campaign.save
  end

  def pagos
    Pago.create(fecha: Date.new(2017, 8, 11))
    Pago.create(fecha: Date.new(2017, 9, 11))
    Pago.create(fecha: Date.new(2017, 10, 10))
    Pago.create(fecha: Date.new(2017, 11, 4))
  end

  def campus
    Campus.create(sistema: 1)
    Campus.create(sistema: 4)
    Campus.create(sistema: 5)
    Campus.create(sistema: 6)
    Campus.create(sistema: 43)
    Campus.create(sistema: 33)
    Campus.create(sistema: 20)
    Campus.create(sistema: 21)
    Campus.create(sistema: 23)
    Campus.create(sistema: 25)
    Campus.create(sistema: 26)
    Campus.create(sistema: 12)
    Campus.create(sistema: 13)
  end

  default()
end
