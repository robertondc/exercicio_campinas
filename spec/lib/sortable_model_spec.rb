require 'spec_helper'

include SortableModel::ClassMethods

describe SortableModel::ClassMethods do
  
  describe ".last_position" do
     it "give zero when there are no people" do
       Person.last_position.should == 0
     end
     
     it "give lastest position plus one when there are people" do
       Person.create(:name => "cassia")
       Person.last_position.should == 1
     end     
  end

  describe ".update_positions_state" do
    
     it "update model positions when positions has changed" do
     
       cassia = Person.create(:name => "cassia")
       roberto = Person.create(:name => "roberto")
       paulo = Person.create(:name => "paulo")
       
       cassia.position.should eq(0)
       roberto.position.should eq(1)
       paulo.position.should eq(2)
       
       old_positions = [cassia.id,roberto.id,paulo.id]
       new_positions = [cassia.id,paulo.id,roberto.id]
      
       Person.update_positions_state(old_positions,new_positions)
       
       cassia.reload.position.should eq(0)
       paulo.reload.position.should eq(1)
       roberto.reload.position.should eq(2)
     end
     
     it "must to update only the records with changed positions" do
       cassia = Person.create(:name => "cassia")
       roberto = Person.create(:name => "roberto")
       paulo = Person.create(:name => "paulo")

       old_positions = [cassia.id,roberto.id,paulo.id]
       new_positions = [cassia.id,paulo.id,roberto.id]
       
       Person.update_positions_state(old_positions,new_positions)
       
       Person.find(cassia.id).updated_at.should eq(cassia.updated_at)
       Person.find(paulo.id).updated_at.should_not eq(paulo.updated_at)
       Person.find(roberto.id).updated_at.should_not eq(roberto.updated_at)
     end
     
  end  
  
  describe ".reorder" do
     it "must to order people according column specified" do
       cassia = Person.create(:name => "cassia")
       roberto = Person.create(:name => "roberto")
       paulo = Person.create(:name => "paulo")
       
       Person.reorder(:name)
       
       Person.find(cassia.id).position.should eq(0)
       Person.find(paulo.id).position.should eq(1)
       Person.find(roberto.id).position.should eq(2)
     end
  end
  
end