class CreateJoinTableUsersJornadas < ActiveRecord::Migration
  def change
    create_join_table :users, :jornadas do |t|
      # t.index [:user_id, :jornada_id]
      # t.index [:jornada_id, :user_id]
    end
  end
end
