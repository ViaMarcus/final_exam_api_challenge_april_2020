class Api::CommentsController < ApplicationController
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :render_error_message

  def create
    comment = Article.find(params[:article]).comments.create(create_params)
    if comment.persisted?
      render json: { message: 'Comment successfully posted!' }, status: :created
    else
      render_error_message(comment.errors)
    end
  end

  def render_error_message(error)
    error_message = if !error.class.method_defined?(:full_messages)
      error.message
    else
      error.full_messages.to_sentence
    end

    render json: { message: error_message }, status: 422
  end

  private

  def create_params
    params.permit(:body).merge!(user: current_user)
  end
end
