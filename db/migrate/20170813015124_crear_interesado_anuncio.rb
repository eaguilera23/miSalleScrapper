class CrearInteresadoAnuncio < ActiveRecord::Migration[5.1]
  def change
    create_table(:interesado_anuncio) do |t|
      t.string :nombre
      t.string :empresa
      t.string :email
      t.integer :paquete
    end
  end
end
