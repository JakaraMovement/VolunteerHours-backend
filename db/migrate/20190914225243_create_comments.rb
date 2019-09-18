class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :text
      t.references :user, index: true, foreign_key: {on_delete: :cascade}
      t.references :event, index: true, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
