class CrearUsuario < ActiveRecord::Migration[5.1]
  def change
    create_table :usuarios do |t|
      t.integer :matricula
      t.timestamps null: false
    end
  end
end
