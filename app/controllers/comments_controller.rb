class CommentsController < ApplicationController

before_action :is_commenter?, only: [:edit, :update]

  def upvote
    user = current_user
    if user
      @vote = Vote.new
      @vote.value = 1
      @vote.voter_id = user.id
      @vote.votable_id = params[:comment_id]
      @vote.votable_type = "Comment"
      if @vote.save
        redirect_to comment_url(params[:comment_id])
      else
        redirect_to subs_url
      end
    else
      redirect_to new_session_url
    end
  end

  def downvote
    user = current_user
    if user
      @vote = Vote.new
      @vote.value = -1
      @vote.voter_id = user.id
      @vote.votable_id = params[:comment_id]
      @vote.votable_type = "Comment"
      if @vote.save
        redirect_to comment_url(params[:comment_id])
      else
        redirect_to subs_url
      end
    else
      redirect_to new_session_url
    end
  end

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    render :new

  end

  def new_child
    @comment = Comment.new
    @parent = Comment.find(params[:comment_id])
    @post = Post.find(@parent.post_id)
    render :new
  end

  def show
    @comment = Comment.find(params[:id])

    render :show
  end

  def create
    user = current_user
    if user
      @comment = Comment.new(comment_params)


      @comment.commenter_id = user.id
      if @comment.save
        redirect_to post_url(params[:comment][:post_id])
      else
        render :new
      end
    else
      redirect_to new_session_url
    end

  end

  def edit
    @comment = Comment.find(params[:id])
    @post = Post.find(@comment.post_id)
    render :edit
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to comment_url(@comment)
    else
      render :edit
    end
  end

  def destroy

  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end

  def is_commenter?
    current_user.id == Comment.find(params[:id]).commenter_id
  end
end
