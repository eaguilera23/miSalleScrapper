class Anuncio < ActiveRecord::Base
  belongs_to :anunciante
  has_many :campaigns
end
