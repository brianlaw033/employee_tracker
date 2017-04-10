class CreateProjectsAgain < ActiveRecord::Migration[5.0]
  def change
    create_table(:projects) do |t|
      t.column(:name, :string)
      t.column(:employee_id, :integer)
      t.timestamps()
    end
  end
end
