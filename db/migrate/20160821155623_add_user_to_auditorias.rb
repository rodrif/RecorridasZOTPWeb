class AddUserToAuditorias < ActiveRecord::Migration
  def change
    add_reference :auditorias, :user, index: true, foreign_key: true
  end
end
