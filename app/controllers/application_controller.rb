class ApplicationController < ActionController::Base

  before_action :debug
  protect_from_forgery prepend: true,with: :exception

  before_action :authenticate_user!
  def debug


  end
  private
  def authenticate_token
    authenticate_or_request_with_http_token do |token,options|      
      
=begin       
      token = JWT.decode(token, 'none', false)
      payload = token[0]
      user_json = payload["user"]
      user_id = user_json["id"]

      @current_user=User.find(user_id)
=end

      @current_user=User.find_by(auth_token:token)

    end
  end
end
