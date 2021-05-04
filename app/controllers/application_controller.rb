class ApplicationController < ActionController::Base

  before_action :debug
  protect_from_forgery prepend: true,with: :exception

  before_action :authenticate_user!
  def debug


  end
  private
  def authenticate_token
    authenticate_or_request_with_http_token do |token,options|      
      
      begin
        token = JWT.decode(token, 'none', false)
        payload = token[0]
        user_json = payload["user"]
        user_id = user_json["id"]
        @current_user=User.find(user_id)
      
      rescue JWT::DecodeError
        @current_user=User.find_by(auth_token: token)#legacy
      end      
    end
  end

  def ensure_user_is_admin
    unless current_user.is_admin?
      flash[:error] = "Sin permiso suficiente."
      redirect_to root_path
    end
  end

end
