class CrearCampaign < ActiveRecord::Migration[5.1]
  def change
    create_table :campaigns do |t|
      t.datetime :fecha_inicio
      t.integer :vistas_completadas, default: 0
      t.integer :vistas_contratadas
      t.datetime :fecha_termino
      t.string :destino_click
      t.integer :status
      t.timestamps null: false
    end
  end
end
