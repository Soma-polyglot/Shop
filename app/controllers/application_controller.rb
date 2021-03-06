class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :set_current_user
  protect_from_forgery with: :exception

  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

end