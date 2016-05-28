class ChangeTelefonoInReferentes < ActiveRecord::Migration
  def change
    change_column :referentes, :telefono, :string
  end
end
