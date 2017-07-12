class CrearAnunciante < ActiveRecord::Migration[5.1]
  def change
    create_table :anunciantes do |t|
      t.string :nombre
      t.string :telefono
      t.string :email
      t.string :empresa
      t.timestamps null: false
    end
  end
end
