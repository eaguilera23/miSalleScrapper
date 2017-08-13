class CrearInteresadoCampus < ActiveRecord::Migration[5.1]
  def change
    create_table("interesado_campus") do |t|
      t.string :email
    end
  end
end
