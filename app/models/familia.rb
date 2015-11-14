class Familia < ActiveRecord::Base
  belongs_to :area
  belongs_to :zone
  belongs_to :ranchada
end
