class FixCommentsTableNullFalse < ActiveRecord::Migration[5.2]
  def change
    drop_table :comments

    create_table :comments do |t|
      t.string :content, null: false
      t.integer :author_id, null: false
      t.integer :commentable_id, null: false

      t.timestamps
    end
    add_index :comments, :author_id
    add_index :comments, :commentable_id
  end
end
