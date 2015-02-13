class Sub < ActiveRecord::Base
  validates :title, :description, presence: true

  has_many(:post_subbings,
  class_name: "PostSubbing",
  foreign_key: :sub_id,
  primary_key: :id)

  has_many :posts, through: :post_subbings, source: :post

end
