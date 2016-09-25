class ChangeColumnDniToString < ActiveRecord::Migration
  def change
		change_column :people, :dni, :string
  end
end
