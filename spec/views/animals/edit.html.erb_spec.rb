require 'spec_helper'

describe "animals/edit" do
  before(:each) do
    @animal = assign(:animal, stub_model(Animal,
      :name => "MyString",
      :position => 1
    ))
  end

  it "renders the edit animal form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => animals_path(@animal), :method => "post" do
      assert_select "input#animal_name", :name => "animal[name]"
      assert_select "input#animal_position", :name => "animal[position]"
    end
  end
end
