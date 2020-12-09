class RemoveWelcomeMessage < ActiveRecord::Migration[6.0]
  def change
    drop_table :welcome_messages
  end
end
