class Person < ActiveRecord::Base
  attr_accessible :name
  before_create :give_last_position
  after_destroy :reorder
  
  def give_last_position
    last_position = Person.maximum(:position)
    self.position = last_position.nil? ? 0 : last_position + 1
  end
  def reorder
    
  end
  
end
