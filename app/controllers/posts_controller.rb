class PostsController < ApplicationController
  before_action :is_author?, only: [:edit, :update]

  def upvote
    user = current_user
    if user
      @vote = Vote.new
      @vote.value = 1
      @vote.voter_id = user.id
      @vote.votable_id = params[:post_id]
      @vote.votable_type = "Post"
      if @vote.save
        redirect_to post_url(params[:post_id])
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
      @vote.votable_id = params[:post_id]
      @vote.votable_type = "Post"
      if @vote.save
        redirect_to post_url(params[:post_id])
      else
        redirect_to subs_url
      end
    else
      redirect_to new_session_url
    end
  end

  def show
    @post = Post.find(params[:id])
    @all_comments = @post.comments_by_parent_id
    render :show
  end

  def new
    @subs = Sub.all
    @post = Post.new
    render :new
  end

  def create
    @subs = Sub.all
    user = current_user
    if user
      @post = Post.new(post_params)
      @post.sub_id = params[:post][:sub].last
      @post.author_id = user.id
      if @post.save
        params[:post][:sub].each do |sub|
          PostSubbing.create(post_id: @post.id, sub_id: sub)
        end
        redirect_to post_url(@post)
      else
        render :new
      end
    else
      redirect_to new_session_url
    end
  end

  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all
    @subbings = @post.post_subbings
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    @subs = Sub.all
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id)
  end

  def is_author?
    current_user.id == Post.find(params[:id])
  end

end
