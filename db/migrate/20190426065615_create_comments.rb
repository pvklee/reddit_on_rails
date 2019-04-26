class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :author_id
      t.integer :commentable_id

      t.timestamps
    end
    add_index :comments, :author_id
    add_index :comments, :commentable_id
  end
end
