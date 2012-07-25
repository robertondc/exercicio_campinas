class Person < ActiveRecord::Base
  
  include People::SortableModel
  
  attr_accessible :name
  
  extend People::Sorting
  
    
end
