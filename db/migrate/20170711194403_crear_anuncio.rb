class CrearAnuncio < ActiveRecord::Migration[5.1]
  def change
    create_table :anuncios do |t|
      t.string :ruta_imagen
      t.timestamps null: false
    end
  end
end
