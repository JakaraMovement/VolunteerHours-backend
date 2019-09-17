class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.text :criteria
      t.integer :max_limit
      t.references :region, index: true, foreign_key: true

      t.timestamps
    end
  end
end
