class Alert < ActiveRecord::Base
  belongs_to :zone
  belongs_to :alert_type
end
