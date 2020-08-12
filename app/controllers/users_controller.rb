class UsersController < ApplicationController
  # this is required because we are dealing with rails API
  skip_before_action :verify_authenticity_token

  # allows us to create a new user and return the data as JSON
  # the create end point will be used for the register component on the client side
  def create
    @user = User.create(user_params)
    if @user.save
      render json: @user, status: :created
    end
  end

  def login
    
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