class ApplicationController < ActionController::Base
  include Nyauth::ControllerConcern

  protect_from_forgery with: :exception

  before_action :require_authentication
  helper_method :current_user
  helper_method :aqua_api

  private

  def current_user
    current_authenticated(as: :user)
  end

  def aqua_api
    return unless current_user.present?
    @aqua_api || @aqua_api = AquaDataService.new(current_user.owner_id || 46228846)
  end

  def require_authentication
    require_authentication! as: :user
  end
end
