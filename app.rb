require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('lib/**/*.rb')
require('./lib/division')
require('./lib/employee')
require('./lib/project')
require('pg')
require('pry')

# INDEX PAGE
get('/') do
  @projects = Project.all()
  @divisions = Division.all()
  @employees = Employee.all()
  erb(:index)
end

post('/new/division') do
  name = params.fetch('name')
  division = Division.create({:name=> name})
  redirect to ('/')
end

post('/new/project') do
  name = params.fetch('name')
  Project.create({:name => name})
  redirect to ("/")
end

#PROJECT PAGE
get('/projects/:id') do
  id = Integer(params.fetch('id'))
  @project = Project.find(id)
  @employees = Employee.all()
  @employees_project = @project.employees()
  erb(:project)
end

patch('/employee_projects/:id') do
  project_id = Integer(params.fetch('id'))
  employee_id = Integer(params.fetch('employee_id'))
  employee = Employee.find(employee_id)
  employee.update({:project_id => project_id})
  redirect to ("/projects/#{project_id}")
end

patch ("/update/project/:id") do
  id = Integer(params.fetch('id'))
  name = params.fetch("name")
  project = Project.find(id)
  project.update({:name => name})
  redirect to ("/projects/#{id}")
end

delete ("/delete/project/:id") do
  id = Integer(params.fetch('id'))
  project = Project.find(id)
  project.delete()
  redirect to ('/')
end

# DIVISION PAGE
get('/divisions/:id') do
  id = Integer(params.fetch('id'))
  @division = Division.find(id)
  @employees = @division.employees()
  @all_employees = Employee.all()
  erb(:division)
end

post('/new/employee/:id') do
  name = params.fetch('name')
  division_id = Integer(params.fetch('id'))
  division = Division.find(division_id)
  division.employees.create({:name => name})
  redirect to ("/divisions/#{division_id}")
end

patch ("/update/division/:id") do
  id = Integer(params.fetch('id'))
  name = params.fetch("name")
  division = Division.find(id)
  division.update({:name => name})
  redirect to ("/divisions/#{id}")
end

delete ("/delete/division/:id") do
  id = Integer(params.fetch('id'))
  division = Division.find(id)
  division.delete()
  redirect to ('/')
end

patch('/division_employee/:id') do
  division_id = Integer(params.fetch('id'))
  employee_id = Integer(params.fetch('employee_id'))
  employee = Employee.find(employee_id)
  employee.update({:division_id => division_id})
  redirect to ("/divisions/#{division_id}")
end

#EMPLOYEE PAGE
get("/employees/:id") do
  id = Integer(params.fetch('id'))
  @employee = Employee.find(id)
  @division = @employee.division()
  @project = @employee.project()
  @projects = Project.all()
  erb(:employee)
end

patch ("/update/employee/:id") do
  id = Integer(params.fetch('id'))
  name = params.fetch("name")
  employee = Employee.find(id)
  employee.update(:name => name)
  redirect to ("/employees/#{id}")
end

delete ("/delete/employee/:id") do
  id = Integer(params.fetch('id'))
  employee = Employee.find(id)
  employee.delete()
  redirect to ('/')
end

patch('/projects_employee/:id') do
  employee_id = Integer(params.fetch('id'))
  project_id = Integer(params.fetch('project_id'))
  employee = Employee.find(employee_id)
  employee.update({:project_id => project_id})
  redirect to ("/employees/#{employee_id}")
end
