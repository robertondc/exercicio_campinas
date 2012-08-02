module SortableModel
    
  extend ActiveSupport::Concern
  
  included do
    default_scope order("position")
    before_create :put_last_position
    after_destroy :reorder_positions          
  end

  private

  def put_last_position
   self.position = self.class.last_position
  end
  
  def reorder_positions
    self.class.reorder(:position)
  end

  module ClassMethods
  
    def update_positions(id,position)
      person = Person.find(id)
      if (position.to_i > person.position)
        update_all(
            ['position = position-1 where position <= ?', position]
        )
      else
       update_all(
            ['position = position+1 where position >= ?', position]
        )
      end
      person.position = position
      person.save
    end
  
    def reorder(column)
      models = self.unscoped.all(:order => column)
      replace_position_with_index(models)
    end
  
    def last_position
      last = self.maximum(:position)
      last.nil? ? 0 : last + 1
    end
    
    private
          
    def replace_position_with_index(models)
      models.each_with_index do |model,index|
        update_model_position(model,index) if model.position != index
      end
    end
    
    def update_model_position(model,new_position)
      model.position = new_position
      model.save
    end
    
  end
    
end
