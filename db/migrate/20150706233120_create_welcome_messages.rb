class CreateWelcomeMessages < ActiveRecord::Migration
  def change
    create_table :welcome_messages do |t|
      t.string :mensaje
      t.datetime :fecha_desde
      t.datetime :fecha_hasta
      t.references :person, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
