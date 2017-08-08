class RelacionarFeedbackUsuario < ActiveRecord::Migration[5.1]
  def change
    add_reference(:feedback, :usuario, foreign_key: {to_table: :usuarios})
  end
end
