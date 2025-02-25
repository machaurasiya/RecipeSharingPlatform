class TagsController < ApplicationController
  before_action :authorize_request
  load_and_authorize_resource
  before_action :set_tag, only: [:show, :update, :destroy]
  
  def index
    # @tags = Tag.all
    @tags = params[:q].present? ? Tag.search(params[:q]) : Tag.all

    render json: @tags
  end

  def show
    render json: @tag
  end

  def create
    @tag = current_user.tags.new(tag_params)

    if @tag.save
      render json: @tag, status: :created, location: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  def update
    if @tag.update(tag_params)
      render json: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @tag.destroy
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:user_id, :tag_name)
  end
end
