class CreatePedidos < ActiveRecord::Migration
  def change
    create_table :pedidos do |t|
      t.datetime :fecha
      t.string :descripcion
      t.references :person, index: true, foreign_key: true
      t.boolean :completado

      t.timestamps null: false
    end
  end
end
