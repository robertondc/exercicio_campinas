module People

  module Sorting
    
    def update_positions_state(old_positions,new_positions)
        old_positions.each_with_index do |person_id,old_index|
          new_index = new_positions.index(person_id)
          if old_index != new_index
            person = Person.find(person_id)
            update_person_position(person,new_index.to_i)
          end
        end
      end
    
      def reorder(column)
        people = Person.unscoped.all(:order => column)
        replace_position_with_index(people)
      end
    
      def last_position
        last_position = Person.maximum(:position)
        last_position.nil? ? 0 : last_position + 1
      end
    
      def reorder_positions
        reorder(:position)
      end
    
      private
    
      def replace_position_with_index(people)
        people.each_with_index do |person,index|
          update_person_position(person,index) if person.position != index
        end
      end
      
      def update_person_position(person,new_position)
        person.position = new_position
        person.save
      end
      
    end
    
    
    module SortableModel
      def self.included(base)
        base.class_eval do
          default_scope order("position")
          before_create :put_last_position
          after_destroy :reorder_positions
        end
      end
      
      def put_last_position
        self.position = last_position
      end
    end
    
  end
