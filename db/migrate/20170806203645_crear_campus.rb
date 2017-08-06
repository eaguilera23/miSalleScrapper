class CrearCampus < ActiveRecord::Migration[5.1]
  def change
    create_table :campus do |t|
      t.integer :sistema
    end
  end
end
