class Campaign < ActiveRecord::Base
  belongs_to :anunciante
  belongs_to :anuncio
  has_many :clicks
end
