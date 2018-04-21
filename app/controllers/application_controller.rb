class ApplicationController < ActionController::Base
  include Nyauth::ControllerConcern

  protect_from_forgery with: :exception

  before_action :require_authentication
  helper_method :current_user

  private

  def current_user
    current_authenticated(as: :user)
  end

  def require_authentication
    require_authentication! as: :user
  end
end
