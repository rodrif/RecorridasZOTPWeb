class AddCodeToRol < ActiveRecord::Migration
  def change
    add_column :roles, :code, :integer
  end
end
