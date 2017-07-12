require_relative "#{Dir.pwd}/app/modelos/campaign.rb"
require_relative "#{Dir.pwd}/app/modelos/anuncio.rb"
module Publicidad
  module_function

  def mostrar_anuncios
    campaigns = Campaign.where(status: :activo).order(:vistas_completadas).includes(:anuncio).take(2)
    anuncios = []
    campaigns.each do |c|
      mapa = {
        campaign_id: c.id,
        destino_click: c.destino_click,
        ruta_imagen: c.anuncio.ruta_imagen
      }
      anuncios << mapa
    end

    anuncios
  end

  def test
    5.times do |i|
      c = Campaign.new(status: :activo, vistas_completadas: i)
      anuncio = Anuncio.create(ruta_imagen: "url #{i}")
      c.anuncio = anuncio
      c.save
    end
    5.times do |i|
      c = Campaign.create(status: :no_activo)
      anuncio = Anuncio.create(ruta_imagen: "url #{i + 5}")
      c.anuncio = anuncio
      c.save
    end
  end

end
