class Appointment < ApplicationRecord
  belongs_to :salon_info
  belongs_to :salon_service

  validates :user_name, :gender, :start_time, presence: true
  validates :mobile,:presence => true,
                 :numericality => true,
                 :length => { :minimum => 10, :maximum => 15 }
end
