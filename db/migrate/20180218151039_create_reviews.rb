class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :document_id
      t.integer :review_by_id
      t.boolean :approved
      t.timestamps
    end
  end
end
