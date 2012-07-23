class AddPositionToPerson < ActiveRecord::Migration
  def change
    add_column :people, :position, :integer, :null => false, :default => 0
  end
end
