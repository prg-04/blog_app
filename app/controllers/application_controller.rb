class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.first
    @current_user
  end

  helper_method :current_user
end
