require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "PersonaSinNombre" do

  	persona = Person.new(apellido: 'Apellido')

  	assert persona.invalid?
  end
end


