class Institucion < ActiveRecord::Base
  belongs_to :state
  belongs_to :zone
end
