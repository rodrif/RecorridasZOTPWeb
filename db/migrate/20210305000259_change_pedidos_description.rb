class ChangePedidosDescription < ActiveRecord::Migration[6.0]
  def change
    change_column :pedidos, :descripcion, :text
  end
end
