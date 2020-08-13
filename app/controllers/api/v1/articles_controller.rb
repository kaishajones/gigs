module Api::V1
  class ArticlesController < ApplicationController
  
    skip_before_action :verify_authenticity_token
    before_action :authorize_request

    def create 
      @article = @current_user.articles.create(article_params)
      render json: @article, include: :user, status: :created
    end

    def show
      @article = @current_user.articles.where(id: params[:id])
      render json: @article, include: :user, status: :ok
    end

    def index
      @articles = @current_user.articles
      render json: @articles, include: :user, status: :ok
    end

    private
    def article_params
      params.permit(
        :title, 
        :content,
        :user_id
      )
    end
  end
end