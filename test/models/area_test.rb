require 'test_helper'

class AreaTest < ActiveSupport::TestCase
  test "area con numeros" do
    area = Person.new(nombre: 'area con numero 1')
    assert area.invalid?
  end
end
