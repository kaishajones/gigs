module Api::V1
  class UsersController < ApplicationController
    # this is required because we are dealing with rails API
    skip_before_action :verify_authenticity_token
    before_action :authorize_request, except: %i[create login]
    # allows us to create a new user and return the data as JSON
    # the create end point will be used for the register component on the client side
    def create
      @user = User.create(user_params)
      if @user.save
        render json: @user, status: :created
      end
    end

    def login
      user = User.find_by(email: params[:email])
      user = user.authenticate(params[:password])
      render json: {
        token: JsonWebToken.encode(user_id: user.id), 
        user: user
      }
    end

    def show
      render json: @current_user, status: :ok
    end

    def update
      if @current_user.update(user_params)
        render json: @current_user, status: :ok
      end
    end

    private 
    def user_params
      params.permit(
        :firstname, 
        :lastname,
        :email,
        :password,
        :address,
        :profile_photo,
        :username

      )
    end
  end
end