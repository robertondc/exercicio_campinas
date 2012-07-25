class Person < ActiveRecord::Base
  
  attr_accessible :name
  
  extend People::Sorting
    
  default_scope order("position")
  
  before_create :put_last_position
  after_destroy :reorder_positions
  
  def put_last_position
    self.position = last_position
  end
  
    
end
