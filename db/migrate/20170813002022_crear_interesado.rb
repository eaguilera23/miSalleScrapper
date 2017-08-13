class CrearInteresado < ActiveRecord::Migration[5.1]
  def change
    create_table(:interesados) do |t|
      t.string :email
    end
  end
end
