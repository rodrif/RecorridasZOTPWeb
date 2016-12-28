require 'test_helper'

class AreaTest < ActiveSupport::TestCase
    test "area con numeros" do
        area = Area.new(nombre: 'area con numero 2')
        assert area.invalid?
    end
end
