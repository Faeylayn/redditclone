class CommentsController < ApplicationController

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
  end

  def update

  end

  def destroy

  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end

end
