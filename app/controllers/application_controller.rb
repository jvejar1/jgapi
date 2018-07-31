class ApplicationController < ActionController::Base

  before_action :debug
  protect_from_forgery prepend: true,with: :exception

  def debug


  end
  private
  def authenticate_token
    authenticate_or_request_with_http_token do |token,options|
      User.find_by(auth_token:token)
    end
  end
end
