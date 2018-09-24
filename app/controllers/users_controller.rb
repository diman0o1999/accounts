class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def favorites
    @my_favorites_articles = current_user.my_favorites_articles
    @my_favorites_articles = @my_favorites_articles.page(params[:page])
  end

  private

  def set_resource
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:nickname, :first_name, :last_name, :image)
  end
end
