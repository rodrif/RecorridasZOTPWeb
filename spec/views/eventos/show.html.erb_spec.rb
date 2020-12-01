require 'rails_helper'

RSpec.describe "eventos/show", type: :view do
  before(:each) do
    @evento = assign(:evento, Evento.create!(
      :titulo => "Titulo",
      :descripcion => "Descripcion",
      :ubicacion => "Ubicacion",
      :persona => nil,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Titulo/)
    expect(rendered).to match(/Descripcion/)
    expect(rendered).to match(/Ubicacion/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
