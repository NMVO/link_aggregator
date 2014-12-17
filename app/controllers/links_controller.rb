class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  
  def index
    @links = Link.order(votes: :asc)
  end

  def show
    @link = Link.find(params[:id])
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.create(link_params)
    if @link.save
      redirect_to link_path(@link)
    else
      render :new
    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(link_params)
      redirect_to link_path(@link)
    else
      render :edit
    end
  end

  def destroy
    @link = Link.find(params[:id])
    if @link.destroy
      redirect_to links_path
    else
      render :new
    end
  end

  def upvote
    if @link.votes += 1
      @link.save
      redirect_to root_path
    else
      render :new
    end
  end

  def downvote
    if @link.votes -= 1
      @link.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def link_params
    params.require(:link).permit(:title, :url, :votes)
  end

  def set_link
    @link = Link.find(params[:id])
  end
end
