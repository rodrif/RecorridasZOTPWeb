class RemoveWelcomeMessage < ActiveRecord::Migration
  def change
    drop_table :welcome_messages
  end
end
