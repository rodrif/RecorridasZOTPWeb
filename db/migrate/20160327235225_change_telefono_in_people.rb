class ChangeTelefonoInPeople < ActiveRecord::Migration
  def change
    change_column :people, :telefono, :string
  end
end
