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
