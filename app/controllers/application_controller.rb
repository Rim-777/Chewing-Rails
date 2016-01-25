require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # protect_from_forgery with: :null_session

  rescue_from CanCan::AccessDenied do |exception|
    render nothing: true, alert: exception.message
    # redirect_to root_path, alert: exception.message
  end

  check_authorization unless: :devise_controller?
end
