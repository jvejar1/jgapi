class ApplicationController < ActionController::Base

  before_action :debug
  protect_from_forgery prepend: true,with: :exception


  def debug


  end
end
