class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize_request
  
  def create
    @article = @current_user.articles.where(id: params[:article_id]).first
    if @article.comments.create(comments_params)
      render json: @article.comments, status: :ok
    end
  end

  private 
    def comments_params
      params.permit(
        :content, 
        :user_id,
        :article_id
      )
    end

end
