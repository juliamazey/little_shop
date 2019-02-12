class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :current_order

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def require_admin
    render file: "/public/404" unless current_admin?
  end

  def current_order
    Order.last #find(session[:id])
  end

  def current_merchant
    current_user && current_user.merchant?
  end

  def require_merchant
    render file: "/public/404" unless current_merchant?
  end
end
