class AddIndexesToMembers < ActiveRecord::Migration[8.0]
  def change
    add_index :members, :email, unique: true
    add_index :members, :rank, unique: true
  end
end
