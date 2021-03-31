class ChangeMaxLimitColumnType < ActiveRecord::Migration[5.2]
  def up
    change_column :events, :max_limit, :float
  end

  def down
    change_column :events, :max_limit, :integer
  end
end
