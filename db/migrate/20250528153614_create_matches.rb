class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.references :white_player, foreign_key: { to_table: :members }
      t.references :black_player, foreign_key: { to_table: :members }
      t.string :result, null: false

      t.timestamps
    end
  end
end
