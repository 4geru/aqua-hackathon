class ApplicationController < ActionController::Base
  include Nyauth::ControllerConcern
  before_action -> { require_authentication! as: nyauth_client_name }
  helper_method :current_user

  private

  def current_user
    current_authenticated(as: :user)
  end
end
