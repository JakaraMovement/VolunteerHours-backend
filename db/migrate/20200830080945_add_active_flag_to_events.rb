class AddActiveFlagToEvents < ActiveRecord::Migration[5.2]
  def up
    add_column :events, :active, :boolean, default: true
    set_all_events_active
  end
  
  def down
    remove_column :events, :active
  end

  def set_all_events_active
    Event.update_all(active: true)
  end
end
