require "application_responder"

class ApplicationController < ActionController::Base

  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_csrf_token

  protect_from_forgery with: :null_session

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  respond_to :html, :js, :json

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    flash[:error] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    redirect_to(root_path)
  end

  def set_csrf_token
    gon.csrf_token = form_authenticity_token
  end

  protected

  def after_sign_in_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
end
