class CreateMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :members do |t|
      t.string :name
      t.string :email
      t.date :birthday
      t.integer :games_played, default: 0
      t.integer :rank

      t.timestamps
    end

    add_index :members, :email, unique: true
    add_index :members, :rank, unique: true
  end
end
