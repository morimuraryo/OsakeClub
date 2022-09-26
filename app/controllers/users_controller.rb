class UsersController < ApplicationController
  def index
    @users = User.all
    @user = current_user
    @osakenew = Osake.new
  end

  def show
    @osakenew = Osake.new
    @user = User.find(params[:id])
    @osakes = @user.osakes
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user.id)
    else
      if @user.update(user_params)
        flash[:notice] = "You have updated user successfully."
        redirect_to user_path(@user.id)
      else
        render :edit
      end
    end
  end

private

def user_params
  params.require(:user).permit(:name, :introduction, :profile_image)
end

end
