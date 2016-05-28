class CreateAuditorias < ActiveRecord::Migration
  def change
    create_table :auditorias do |t|
      t.datetime :fecha
      t.string :email
      t.string :accion
      t.string :entidad
      t.integer :entity_id

      t.timestamps null: false
    end
  end
end
