dir_pwd = Dir.pwd
require 'sinatra/activerecord'
require_relative "#{dir_pwd}/app/modelos/campaign.rb"
require_relative "#{dir_pwd}/app/modelos/anuncio.rb"
require_relative "#{dir_pwd}/app/modelos/anunciante.rb"
module PublicidadController
  module_function

  def mostrar_anuncio
    campaign = Campaign.where(status: :activo).order(:vistas_completadas).includes(:anuncio).first
    if campaign.nil? then
      campaign = Campaign.find(1)
      campaign.update(status: :activo)
    end

    Campaign.increment_counter(:vistas_completadas, campaign, touch: true)

    verificar_estado_campaign(campaign.id)

    campaign
  end

  def registrar_click(campaign_id, matricula)
   usuario = Usuario.find_by(matricula: matricula)
   click = Click.new
   click.usuario = usuario
   click.campaign_id = campaign_id
   if click.save then
     4.times do
       Campaign.increment_counter(:vistas_completadas, campaign_id)  
     end
   end

   verificar_estado_campaign(campaign_id)

  end

  def verificar_estado_campaign(campaign_id)
    campaign = Campaign.find(campaign_id)

    if  campaign.vistas_completadas >= campaign.vistas_contratadas then
      campaign.update(status: :no_activo)
    end
  end

  def test
    default_anuncio = Anuncio.create(ruta_imagen: "default imagen")
    default = Campaign.new(status: :no_activo, vistas_contratadas: 100000, destino_click: "default url click")
    default.anuncio = default_anuncio
    default.save

    5.times do |i|
      c = Campaign.new(status: :activo, vistas_completadas: i, vistas_contratadas: i + 1)
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
