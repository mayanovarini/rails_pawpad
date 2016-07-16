class Review < ActiveRecord::Base
  belongs_to :pad
  belongs_to :user
end
