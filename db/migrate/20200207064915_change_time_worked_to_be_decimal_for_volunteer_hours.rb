class ChangeTimeWorkedToBeDecimalForVolunteerHours < ActiveRecord::Migration[5.2]
  def up
    change_column :volunteer_hours, :time_worked, :float
  end

  def down
    change_column :volunteer_hours, :time_worked, :float
  end
end
