class Document < ActiveRecord::Base
  belongs_to :assigned_to, class_name: 'User'
  belongs_to :document_store
end
