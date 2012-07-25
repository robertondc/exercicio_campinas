require 'spec_helper'
include People::Sorting

describe People::Sorting do
  
  describe ".last_position" do
     it "give zero when there are no people" do
       last_position.should == 0
     end
     
     it "give lastest position plus one when there are people" do
       Person.create(:name => "cassia")
       last_position.should == 1
     end     
  end

  describe ".update_positions_state" do
    
     it "update index id change" do
       cassia = Person.create(:name => "cassia")
       roberto = Person.create(:name => "roberto")
       paulo = Person.create(:name => "paulo")

       old_positions = [cassia.id,roberto.id,paulo.id]
       new_positions = [roberto.id,cassia.id,paulo.id]
       
       update_positions_state(old_positions,new_positions)
       
       Person.find(roberto.id).position.should == 0
       Person.find(cassia.id).position.should == 1
       Person.find(paulo.id).position.should == 2
     end
     
     it "must to update only the records with changed positions" do
       cassia = Person.create(:name => "cassia")
       roberto = Person.create(:name => "roberto")
       paulo = Person.create(:name => "paulo")

       old_positions = [cassia.id,roberto.id,paulo.id]
       new_positions = [cassia.id,paulo.id,roberto.id]
       
       update_positions_state(old_positions,new_positions)
       
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
       
       reorder(:name)
       
       Person.find(cassia.id).position.should == 0
       Person.find(paulo.id).position.should == 1
       Person.find(roberto.id).position.should == 2
     end
  end
  
end