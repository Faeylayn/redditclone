class Comment<ActiveRecord::Base

  validates :commenter_id, :content, :post_id, presence: true

  belongs_to(
    :post,
    :class_name => "Post",
    foreign_key: :post_id,
    primary_key: :id
  )

  belongs_to(:parent,
    :class_name => "Comment",
    :foreign_key => :parent_comment_id,
    :primary_key => :id
  )

  belongs_to(:commenter,
      :class_name => "User",
      :foreign_key => :commenter_id,
      :primary_key => :id
  )

  has_many(:comments,
  :class_name => "Comment",
  :foreign_key => :parent_comment_id,
  :primary_key => :id
)

end
