class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :nombre
      t.boolean :puede_crear_persona
      t.boolean :puede_editar_persona
      t.boolean :puede_borrar_persona
      t.boolean :puede_ver_telefono_persona
      t.boolean :puede_ver_web
      t.boolean :puede_crear_visita
      t.boolean :puede_editar_visita
      t.boolean :puede_borrar_visita

      t.timestamps null: false
    end
  end
end
