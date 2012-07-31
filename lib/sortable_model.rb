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
  
    def update_positions(positions)
      update_all(
          ['position = FIND_IN_SET(id, ?)', positions.join(',')],{ :id => positions }
      )
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
