class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :set_action_cable_identifier
  before_action :configure_permitted_parameters, if: :devise_controller?

  def flash_import_errors(import_errors)
    import_errors.each do |ie|
      flash_import_message(:import, ie[:row], ie[:error])
    end
  end

  def flash_import_message(type, row, text)
    flash[type] ||= []
    flash[type] << "row number: #{row} error: #{text}"
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:team_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:team_name])
    devise_parameter_sanitizer.permit(:invite, keys: [:team_name])
  end

  private

  def set_action_cable_identifier
    cookies.encrypted[:session_id] = session.id.to_s
  end
end
