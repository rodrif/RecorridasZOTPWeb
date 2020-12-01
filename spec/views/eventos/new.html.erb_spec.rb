require 'rails_helper'

RSpec.describe "eventos/new", type: :view do
  before(:each) do
    assign(:evento, Evento.new(
      :titulo => "MyString",
      :descripcion => "MyString",
      :ubicacion => "MyString",
      :persona => nil,
      :user => nil
    ))
  end

  it "renders new evento form" do
    render

    assert_select "form[action=?][method=?]", eventos_path, "post" do

      assert_select "input#evento_titulo[name=?]", "evento[titulo]"

      assert_select "input#evento_descripcion[name=?]", "evento[descripcion]"

      assert_select "input#evento_ubicacion[name=?]", "evento[ubicacion]"

      assert_select "input#evento_persona_id[name=?]", "evento[persona_id]"

      assert_select "input#evento_user_id[name=?]", "evento[user_id]"
    end
  end
end
