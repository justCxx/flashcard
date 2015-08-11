class UserSessionsController < ApplicationController
  skip_before_filter :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(login_params[:email], login_params[:password])
      redirect_back_or_to(new_review_path, notice: "Login successfull")
    else
      flash.now[:alert] = "Login failed!"
      render action: "new"
    end
  end

  def destroy
    logout
    redirect_to(login_path, notice: "Logged out")
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
