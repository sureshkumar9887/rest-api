class CreateEmployeeDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :employee_details do |t|
      t.string :employee_id, null: false, unique: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false, unique: true
      t.text :phonenumber, array:true, default: []
      t.date :date_of_joining, null: false
      t.integer :salary, null: false
      t.timestamps
    end
  end
end
