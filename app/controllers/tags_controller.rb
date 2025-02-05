class TagsController < ApplicationController
  before_action :set_tag, only: [:show]
  
  def index
    @tags = Tag.all

    render json: @tags
  end

  def show
    render json: @tag
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      render json: @tag, status: :created, location: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:tag_name)
  end
end
