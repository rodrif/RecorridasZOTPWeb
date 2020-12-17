class AddColumnsToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events,:descripcion, :string
    add_column :events,:description, :string
    add_column :events,:location, :string
    add_reference :events, :person, foreign_key: true
    add_reference :events, :user, foreign_key: true
  end
end
