class CreateEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table(:employees) do |t|
      t.column(:name, :string)
      # t.column(:division_id, :integer)
      t.timestamps()
    end
  end
end
