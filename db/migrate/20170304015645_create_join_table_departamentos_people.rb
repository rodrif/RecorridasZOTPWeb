class CreateJoinTableDepartamentosPeople < ActiveRecord::Migration
  def change
    create_join_table :departamentos, :people do |t|
      # t.index [:departamento_id, :person_id]
      # t.index [:person_id, :departamento_id]
    end
  end
end
