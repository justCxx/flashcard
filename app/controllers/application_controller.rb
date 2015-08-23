class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login, :set_locale

  def not_authenticated
    redirect_to login_url, alert: (t :require_login)
  end

  def set_locale
    locale = detect_locale
    if locale && I18n.available_locales.include?(locale.to_sym)
      I18n.locale = locale.to_sym
    end
  end

  private

  def detect_locale
    if current_user
      current_user.locale
    elsif params[:locale]
      params[:locale]
    else
      http_accept_language.compatible_language_from(I18n.available_locales)
    end
  end
end
