class SubsController < ApplicationController
  def new
    @sub = Sub.new
    render :new

  end

  def create

  end

  def index
      @subs = Sub.all
      render :index
  end

  def show

  end

  def edit

  end

  def update

  end

end
