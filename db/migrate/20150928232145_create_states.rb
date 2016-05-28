class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :nombre

      t.timestamps null: false
    end
  end
end
