class Person < ActiveRecord::Base
  
  include SortableModel
  
  attr_accessible :name
  
end
