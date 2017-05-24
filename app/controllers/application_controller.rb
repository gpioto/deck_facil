class ApplicationController < ActionController::Base
  helper_method :current_user
  protect_from_forgery with: :exception
end
