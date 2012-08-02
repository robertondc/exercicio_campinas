class AddIndexToPerson < ActiveRecord::Migration
  def change
    add_index(:people, :position, { :name => "people_position_index", :unique => true })
  end
end
