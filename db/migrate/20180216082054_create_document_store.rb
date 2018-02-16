class CreateDocumentStore < ActiveRecord::Migration[5.1]
  def change
    create_table :document_stores do |t|
      t.string :name
      t.string :store_source
      t.string :type
      t.json :options
    end
  end
end
