class AgregarFeedback < ActiveRecord::Migration[5.1]
  def change
    create_table :feedback do |t|
      t.string :texto
    end
  end
end
