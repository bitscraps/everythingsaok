class AddColumnAssignedTo < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :assigned_to_id, :integer
  end
end
