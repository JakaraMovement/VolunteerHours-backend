class CreateUserEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :user_events do |t|
      t.references :user, index: true, foreign_key: {on_delete: :cascade}
    	t.references :event, index: true, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
