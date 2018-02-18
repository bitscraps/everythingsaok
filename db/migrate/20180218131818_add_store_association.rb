class AddStoreAssociation < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :document_store_id, :integer
  end
end
