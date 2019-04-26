class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.integer :votable_id, null: false
      t.string :votable_type, null: false
      t.integer :user_id, null: false
      t.integer :value, default: 0

      t.timestamps
    end
    add_index :votes, [:user_id, :votable_id, :votable_type], unique: true
  end
end
