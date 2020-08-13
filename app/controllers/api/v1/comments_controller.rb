module Api::V1
  class CommentsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authorize_request
    
    def create
      @article = @current_user.articles.where(id: params[:article_id]).first
      if @article.comments.create(comments_params)
        render json: @article.comments, include: {article: {include: :user}}, status: :ok
      end
    end

    def show
      @article = @current_user.articles.where(id: params[:article_id]).first
      @comment = @article.comments.where(id: params[:id]).first
      render json: @comment, include: {article: {include: :user}}
    end

    def index
      @article = @current_user.articles.where(id: params[:article_id]).first
      @comments = @article.comments
      render json: @comments, include: {article: {include: :user}}
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
  
 
end
