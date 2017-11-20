class AddInstitucuionToPeople < ActiveRecord::Migration
  def change
    add_reference :people, :institucion, index: true, foreign_key: true
  end
end
