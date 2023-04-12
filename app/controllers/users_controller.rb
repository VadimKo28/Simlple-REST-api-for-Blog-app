class UsersController < ApplicationController

  def index
    users = User.left_outer_joins(:articles).
    select("users.id, users.name, COUNT(articles.id) AS articles_count").
    group("users.id, users.name")

    render json: { status: :ok, message: "Loaded Users", data: users }
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: { status: 201, message: "Saved User", data: user }
    else
      render json: { message: "User not saved", errors: user.errors, status: :unprocessable_entity}
    end
  end

  def show
    user = find_user(params[:id])
    render json: { status: :ok, message: "Loaded User", data: user }
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: { status: 204, message: "Destroy User", data: user }
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: { status: :ok, message: "Update User", data: user }
    else
      render json: { message: "User not updated", errors: user.errors, status: :unprocessable_entity}
    end
  end

  private

  def find_user(id)
    users = User.left_outer_joins(:articles).
    select("users.id, users.name, COUNT(articles.id) AS articles_count").
    where(id: id).group("users.id, users.name")
    end

  def user_params
    params.require(:user).permit(:name)
  end
end
