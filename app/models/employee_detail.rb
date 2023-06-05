class EmployeeDetail < ApplicationRecord

	validates :email, presence: true, uniqueness: true, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/
	validates :first_name, :last_name, presence: true, length: {minimum: 2}
	validates :date_of_joining, comparison: {less_than: Time.now()}
	validates :salary, numericality: {only_integer: true}
	validates :employee_id, presence: true, uniqueness: true

end
