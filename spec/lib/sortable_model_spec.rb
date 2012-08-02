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

  describe ".update_positions" do
    
     it "update model positions when positions has changed" do
     
       cassia = Person.create(:name => "cassia")
       roberto = Person.create(:name => "roberto")
       paulo = Person.create(:name => "paulo")
       
       cassia.position.should eq(0)
       roberto.position.should eq(1)
       paulo.position.should eq(2)
             
       Person.update_positions(cassia.id,2)

       cassia.reload.position.should eq(2)
       roberto.reload.position.should eq(0)
       paulo.reload.position.should eq(1)       
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