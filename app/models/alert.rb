class Alert < ApplicationRecord
  belongs_to :zone
  belongs_to :alert_type
end
