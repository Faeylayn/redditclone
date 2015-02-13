class Post<ActiveRecord::Base
  validates :title, :content, :author_id, presence: true

  has_many(
    :post_subbings,
    class_name: "PostSubbing",
    foreign_key: :post_id,
    primary_key: :id
  )
end
