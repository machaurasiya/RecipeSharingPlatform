class CommentsController < ApplicationController
    before_action :set_recipe
    before_action :set_comment, only: [:show, :update, :destroy]

  def index
    @comments = @recipe.comments.all

    render json: @comments
  end

  def show
    render json: @comment
  end

  def create
    @comment = @recipe.comments.new(comment_params)

    if @comment.save
    #   render json: @comment, status: :created, location: @
        render json: @comment, status: :created, location: recipe_comment_url(@recipe, @comment)
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:user_id, :recipe_id, :content)
  end
end
