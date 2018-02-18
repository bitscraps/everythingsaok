class Review < ActiveRecord::Base
  belongs_to :document
  belongs_to :review_by, class_name: 'User'
end