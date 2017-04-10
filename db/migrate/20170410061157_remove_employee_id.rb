class RemoveEmployeeId < ActiveRecord::Migration[5.0]
  def change
    remove_column(:projects, :employee_id, :integer)
    add_column(:employees, :project_id, :integer)
  end
end
