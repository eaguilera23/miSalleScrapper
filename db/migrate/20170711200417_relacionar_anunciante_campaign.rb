class RelacionarAnuncianteCampaign < ActiveRecord::Migration[5.1]
  def change
    change_table :campaigns do |t|
      t.belongs_to :anunciante, index: true
    end
  end
end
