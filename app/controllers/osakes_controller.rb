class OsakesController < ApplicationController
  def index
    @osakes = Osake.all
    @osake = Osake.new
    @user = current_user
  end

  def create
    @osake = Osake.new(osake_params)
    @osake.user_id = current_user.id
    if @osake.save
      flash[:notice] = "You have created osake successfully."
      # book#showにリダイレクト
      redirect_to osake_path(@osake.id)
    else
      @osakes = Osake.all
      @osakenew = @osake
      @user = current_user
      render :index
    end
  end

  def show
    @osakenew = Osake.new
    @osake = Osake.find(params[:id])
    @user = @osake.user
  end

  def edit
    @osake = Osake.find(params[:id])
    unless @osake.user == current_user
      redirect_to osakes_path
    end
  end

  def update
    @osake = Osake.find(params[:id])
    if @osake.user != current_user
      redirect_to osakes_path
    else
      if @osake.update(osake_params)
        flash[:notice] = "You have updated osake successfully."
        # book#showにリダイレクト
        redirect_to osake_path(@osake.id)
      else
        render :edit
      end
    end
  end

  def destroy
    @osake = Osake.find(params[:id])
    if @osake.user != current_user
      redirect_to osakes_path
    else
      @osake.destroy
      redirect_to osakes_path
    end
  end

# ストロングパラメータ
  private

  def osake_params
    params.require(:osake).permit(:title, :body)
  end

end
