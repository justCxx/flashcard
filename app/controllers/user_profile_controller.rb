class UserProfileController < ApplicationController
  def show
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to profile_path, notice: "User was successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    current_user.destroy
    redirect_to root_path, notice: "User was successfully destroyed!"
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :locale)
  end
end
