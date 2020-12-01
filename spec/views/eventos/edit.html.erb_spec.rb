require 'rails_helper'

RSpec.describe "eventos/edit", type: :view do
  before(:each) do
    @evento = assign(:evento, Evento.create!(
      :titulo => "MyString",
      :descripcion => "MyString",
      :ubicacion => "MyString",
      :persona => nil,
      :user => nil
    ))
  end

  it "renders the edit evento form" do
    render

    assert_select "form[action=?][method=?]", evento_path(@evento), "post" do

      assert_select "input#evento_titulo[name=?]", "evento[titulo]"

      assert_select "input#evento_descripcion[name=?]", "evento[descripcion]"

      assert_select "input#evento_ubicacion[name=?]", "evento[ubicacion]"

      assert_select "input#evento_persona_id[name=?]", "evento[persona_id]"

      assert_select "input#evento_user_id[name=?]", "evento[user_id]"
    end
  end
end
