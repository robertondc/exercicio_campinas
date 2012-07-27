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
    
    def update_positions_state(old_positions,new_positions)
      old_positions.each_with_index do |id,index|
        new_index = new_positions.index(id)
        update_model_position(self.find(id),new_index.to_i) if index != new_index
      end
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
