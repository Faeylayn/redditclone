class Post<ActiveRecord::Base
  validates :title, :content, :author_id, presence: true

  has_many(
    :post_subbings,
    class_name: "PostSubbing",
    foreign_key: :post_id,
    primary_key: :id
  )

  has_many(:comments,
    :class_name => "Comment",
    :foreign_key => :post_id,
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

    def top_level_comments
      self.comments.where(parent_comment_id: nil)
    end

    def comments_by_parent_id
      output = {}
      self.comments.each do |comment|
        if output[comment.parent_comment_id].nil?
          output[comment.parent_comment_id] = [comment]
        else
          output[comment.parent_comment_id] << comment
        end

      end
      output
    end
end
