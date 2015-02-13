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

  has_many :votes, as: :votable

  def score
    self.votes.sum(:value)
  end

  def hotness
    total = 0
    self.votes.each do |vote|
      if vote.created_at > 5.minutes.ago
        vote.value *= 5
      elsif vote.created_at > 30.minutes.ago
        vote.value *= 2
      end
    total += vote.value
    end
    total
  end

end
