class RelacionarCampaignClick < ActiveRecord::Migration[5.1]
  def change
    change_table :clicks do |t|
      t.belongs_to :campaign, index: true
    end
  end
end
