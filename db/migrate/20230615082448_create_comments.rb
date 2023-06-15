class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :author_id, null: false, foreign_key: { to_table: :users }
      t.references :post_id, null: false, foreign_key: true
      t.text :Text

      t.timestamps
    end
  end
end
