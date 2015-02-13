class SubsController < ApplicationController
  before_action :is_mod?, :only => [:edit, :update]

  def new
    @sub = Sub.new
    render :new

  end

  def create
    user = current_user
    if user
      @sub = Sub.new(sub_params)
      @sub.moderator_id = user.id
      if @sub.save
        redirect_to sub_url(@sub)
      else
        render :new
      end
      else
        redirect_to new_session_url
      end

  end

  def index
      @subs = Sub.all
      render :index
  end

  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts
    render :show

  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit

  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      render :edit
    end

  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def is_mod?
    current_user.id == Sub.find(params[:id]).moderator_id
  end
end
