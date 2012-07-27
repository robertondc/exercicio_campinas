require 'spec_helper'

describe "animals/new" do
  before(:each) do
    assign(:animal, stub_model(Animal,
      :name => "MyString",
      :position => 1
    ).as_new_record)
  end

  it "renders new animal form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => animals_path, :method => "post" do
      assert_select "input#animal_name", :name => "animal[name]"
      assert_select "input#animal_position", :name => "animal[position]"
    end
  end
end
