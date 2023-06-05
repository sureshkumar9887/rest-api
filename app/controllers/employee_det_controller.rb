class EmployeeDetController < ApplicationController

	def new
		@employee = EmployeeDetail.new(employee_params)
		phone_numbers = employee_params["phonenumber"].split(',')
		invalid_phone = false
		phone_numbers.each do |phn|
			puts "phone number = #{phn}"
			if /^[0-9]{10,15}$/.match(phn).nil?
				#render json: {:message => "Invalid phone number provided"}, :status => 422
				invalid_phone = true
				break
			end
		end 
		if invalid_phone == false && @employee.save
			render json: {:message => "employee details added successfully"}, :status => 200
		else
		  error_message = {}
		  if invalid_phone == false
		  	error_message = @employee.errors
		  else
		  	error_message = {phonenumber: ["invalid phone number"]}
		  end
		  render json: error_message, :status => 422

		end
	end

	def view
		emp_det = EmployeeDetail.find_by(employee_id: view_params[:employee_id])
		if emp_det.nil?
			render json: {:message => "No record found"}, :status => 422
		else
			render json: emp_det, :status => 200
		end
	end

	def calculate_tax
		emp_det = EmployeeDetail.find_by(employee_id: tax_params[:employee_id])
		no_days_lop = tax_params[:no_days_lop]
		if emp_det.nil?
			render json: {:message => "No record found"}, :status => 422
		else
			current_year = Time.now.strftime("%Y")
			current_financial_year = "01-04-#{current_year}"
			#doj = DateTime.strptime(emp_det.date_of_joining, '%d-%m-%Y')
			doj = emp_det.date_of_joining
			cfy = DateTime.strptime(current_financial_year, '%d-%m-%Y')
			no_of_months = 0
			no_of_days_left = 0 + no_days_lop.to_i
			if doj <= cfy
				no_of_months = 12
				no_of_days_left = no_of_days_left + 0
			else
				no_of_months_left = (doj.year * 12 + doj.month) - (cfy.year * 12 + cfy.month)
				no_of_days_left = no_of_days_left + (doj.day - 1)
				no_of_months = 12 - no_of_months_left
			end
			sal_per_day = emp_det.salary / 30
			total_salary = emp_det.salary * no_of_months
			deduct_salary = sal_per_day * no_of_days_left
			total_salary = total_salary - deduct_salary
			tax = 0
			if total_salary <= 250000
				tax = 0
			elsif total_salary > 250000 && total_salary <= 500000
				salary_remaining = total_salary - 250000
				tax = salary_remaining * 5 / 100
			elsif total_salary > 500000 && total_salary <= 1000000
				salary_remaining = total_salary - 500000
				tax = (250000 * 5 / 100) + (salary_remaining * 10 / 100)
			elsif total_salary > 1000000
				salary_remaining = total_salary - 1000000
				tax = (250000 * 5 / 100) + (500000 * 10 / 100) + (salary_remaining * 20 / 100)
				cess = 0
				if total_salary > 2500000
					cess_salary = total_salary - 2500000
					cess = cess_salary * 2 / 100
				end
				tax = tax + cess
			end
			render json: {:total_tax => tax}
		end
	end
	
	def employee_params
		params.permit(:email, :first_name, :last_name, :date_of_joining, :employee_id, :phonenumber, :salary)
	end
	def view_params
		params.permit(:employee_id)
	end
	def tax_params
		params.permit(:employee_id, :no_days_lop)
	end
end
