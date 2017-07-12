class RelacionarAnuncianteAnuncio < ActiveRecord::Migration[5.1]
  def change
    change_table :anuncios do |t|
      t.belongs_to :anunciante, index: true
    end
  end
end
