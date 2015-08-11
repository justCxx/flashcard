class OauthsController < ApplicationController
  skip_before_filter :require_login, except: :destroy

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if @user = login_from(provider)
      redirect_to root_path, notice: "Logged in from #{provider.titleize}"
    else
      if logged_in?
        link_account(provider)
        redirect_to root_path
      else
        redirect_to root_path, alert: "Failed login from #{provider.titleize}!"
      end
    end
  end

  def destroy
    provider = auth_params[:provider]
    authentication = current_user.authentications.find_by_provider(provider)
    if authentication.present?
      authentication.destroy
      flash[:notice] = "You have unlinked your #{provider.titleize} account."
    else
      flash[:alert] = "You do not have a linked #{provider.titleize} account."
    end

    redirect_to root_path
  end

  private

  def link_account(provider)
    if @user = add_provider_to_user(provider)
      flash[:notice] = "You have successfully linked your GitHub account."
    else
      flash[:alert] = "There was a problem linking your GitHub account."
    end
  end

  def auth_params
    params.permit(:code, :provider)
  end
end
