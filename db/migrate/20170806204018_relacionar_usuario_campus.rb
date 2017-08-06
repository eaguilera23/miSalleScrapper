class RelacionarUsuarioCampus < ActiveRecord::Migration[5.1]
  def change
    add_reference(:usuarios, :campus, foreign_key: {to_table: :campus})
  end
end
