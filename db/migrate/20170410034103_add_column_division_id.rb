class AddColumnDivisionId < ActiveRecord::Migration[5.0]
  def change
    add_column(:employees, :division_id, :integer)
  end
end
