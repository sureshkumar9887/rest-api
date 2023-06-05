# README

API endpoint details

#Create employee details

API : http://localhost:3000/employee_details/update

Method : POST

Request Params : 
{
    employee_id: "EMP01",
    first_name: "sureshkumar",
    last_name: "kannaiyan",
    date_of_joining: 22-05-2023,
    salary: 750000,
    email: "sureshkumar9887@gmail.com",
    phonenumber: [
        9585024946
    ]
}


Success response :

{
    "message": "employee details added successfully"
}

#API for calculate tax of employee

API : http://localhost:3000/employee_details/get_tax

Method : GET

Request Params : 
{
    employee_id: "EMP06",
    no_days_lop: 5
}

Success Response :

{
    "total_tax": 1132500
}
