class PostSubbing<ActiveRecord::Base

  validate :post_id, :sub_id, presence: true

  belongs_to(
    :post,
  class_name: "Post",
  foreign_key: :post_id,
  primary_key: :id
  )

end
