class Animal < ActiveRecord::Base
  
  attr_accessible :name
  
  include SortableModel

end
