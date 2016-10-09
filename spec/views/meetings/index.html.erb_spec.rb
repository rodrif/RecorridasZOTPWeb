require 'rails_helper'

RSpec.describe "meetings/index", type: :view do
  before(:each) do
    assign(:meetings, [
      Meeting.create!(
        :name => "Name"
      ),
      Meeting.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of meetings" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
