class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  def index
    users = User.select("users.id, users.name")
    render json: { status: "SUCCES", message: "Loaded Users", data: users }
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: { status: "SUCCES", message: "Created User", data: user }
    else
      render json: { message: "User not created", errors: user.errors }, status: :unprocessable_entity
    end
  end

  def show
    render json: { status: "SUCCES", message: "Loaded User", data: @user }
  end

  def destroy
    @user.destroy
    render json: { status: "SUCCES", message: "Destroy User", data: @user }
  end

  def update
    if @user.update(user_params)
      render json: { status: "SUCCES", message: "Update User", data: @user }
    else
      render json: { message: "User not updated", errors: user.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
