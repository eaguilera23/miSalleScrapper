class Campaign < ActiveRecord::Base
  enum status: [:activo, :no_activo]

  belongs_to :anunciante
  belongs_to :anuncio
  has_many :clicks
end
