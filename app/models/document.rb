class Document < ActiveRecord::Base
  belongs_to :assigned_to, class_name: 'User'
end
