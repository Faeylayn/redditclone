class Sub < ActiveRecord::Base
  validates :title, :description, presence: true


end
