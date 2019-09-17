class CreateVolunteerHours < ActiveRecord::Migration[5.2]
  def change
    create_table :volunteer_hours do |t|
      t.integer :time_worked
      t.integer :status
      t.references :user, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true

      t.timestamps
    end
  end
end
