class RelacionarCampaignAnuncio < ActiveRecord::Migration[5.1]
  def change
    change_table :campaigns do |t|
      t.belongs_to :anuncio, index: true
    end
  end
end
