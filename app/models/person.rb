class Person < ActiveRecord::Base
  
  extend PeopleSorting
  
  default_scope order("position")

  attr_accessible :name
  before_create :put_last_position
  after_destroy :reorder_positions
  
  def put_last_position
    self.position = last_position
  end
  
    
end
