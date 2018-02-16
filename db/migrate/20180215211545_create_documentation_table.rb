class CreateDocumentationTable < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :title
      t.string :source
      t.datetime :last_review
      t.string :original_documentation
      t.timestamps
    end
  end
end
