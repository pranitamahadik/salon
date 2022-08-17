class SalonInfo < ApplicationRecord
	has_many :salon_services
	has_many :appointments
	accepts_nested_attributes_for :salon_services

	validates :company_name, :gstin, :pan, :chair_count, :day, :open, :closes, presence: true
	validates :company_name, :gstin, :pan, uniqueness: true
	validates :pan,format: { with: /[A-Z]{5}[0-9]{4}[A-Z]{1}/ },:length => {:minimum => 10, :maximum => 10}
	validates :gstin,format: { with: /[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}/ },:length => {:minimum => 15, :maximum => 15}
end
