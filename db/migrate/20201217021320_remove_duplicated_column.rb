class RemoveDuplicatedColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :events,:descripcion
  end
end
