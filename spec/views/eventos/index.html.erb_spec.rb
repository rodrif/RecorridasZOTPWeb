require 'rails_helper'

RSpec.describe "eventos/index", type: :view do
  before(:each) do
    assign(:eventos, [
      Evento.create!(
        :titulo => "Titulo",
        :descripcion => "Descripcion",
        :ubicacion => "Ubicacion",
        :persona => nil,
        :user => nil
      ),
      Evento.create!(
        :titulo => "Titulo",
        :descripcion => "Descripcion",
        :ubicacion => "Ubicacion",
        :persona => nil,
        :user => nil
      )
    ])
  end

  it "renders a list of eventos" do
    render
    assert_select "tr>td", :text => "Titulo".to_s, :count => 2
    assert_select "tr>td", :text => "Descripcion".to_s, :count => 2
    assert_select "tr>td", :text => "Ubicacion".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
