class AddStateReferenceToPedidos < ActiveRecord::Migration
  def change
    add_reference :pedidos, :state, index: true, foreign_key: true
  end
end
