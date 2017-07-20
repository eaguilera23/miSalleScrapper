class CrearPagos < ActiveRecord::Migration[5.1]
  def change
    create_table(:pagos) do |t|
      t.date :fecha
    end
  end
end
