class RelacionarClickUser < ActiveRecord::Migration[5.1]
  def change
    change_table :clicks do |t|
      t.belongs_to :usuario
    end
  end
end
