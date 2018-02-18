class Document < ActiveRecord::Base
  belongs_to :assigned_to, class_name: 'User', optional: true
  belongs_to :document_store
  has_many :reviews
end
