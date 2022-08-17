class SalonService < ApplicationRecord
  belongs_to :salon_info
  has_many :appointments
  validates :service_type, :charges, :duration, presence: true
end
