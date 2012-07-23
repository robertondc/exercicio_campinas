class Person < ActiveRecord::Base
  attr_accessible :name
  before_create :put_last_position
  after_destroy :reorder
  
  def put_last_position
    last_position = Person.maximum(:position)
    self.position = last_position.nil? ? 0 : last_position + 1
  end
  
  def reorder
    people = Person.all(:order => 'position,name')
    people.each_with_index do |person,index|
      person.position = index
      person.save
    end
  end
  
end
