class Api::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    article = Article.find(params[:article]).comments.create(create_params)
    if article.persisted?
      render json: { message: 'Comment successfully posted!' }, status: :created
    else
      error_message = article.errors.messages
      binding.pry
      render json: { message: error_message }, status: 422
    end
  end

  private

  def create_params
    params.permit(:body).merge!(user: current_user)
  end
end
