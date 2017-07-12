class Anunciante < ActiveRecord::Base
  has_many :campaigns
  has_many :anuncios
end
