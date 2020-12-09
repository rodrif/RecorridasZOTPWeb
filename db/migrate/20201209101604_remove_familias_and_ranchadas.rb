class RemoveFamiliasAndRanchadas < ActiveRecord::Migration[6.0]
  def change
    remove_reference :people, :familia, index: true, foreign_key: true
    remove_reference :people, :ranchada, index: true, foreign_key: true
    remove_reference :familias, :ranchada, index: true, foreign_key: true
    drop_table :familias
    drop_table :ranchadas
  end
end
