class AddApellidoAndAreaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :apellido, :string
    add_reference :users, :area, index: true, foreign_key: true
  end
end
