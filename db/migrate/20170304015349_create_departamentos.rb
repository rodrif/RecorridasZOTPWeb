class CreateDepartamentos < ActiveRecord::Migration
  def change
    create_table :departamentos do |t|
      t.string :nombre
      t.references :state, index: true, foreign_key: true
    end
  end
end
