class EvaluationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  def create


    render json:{id_to_erase:1,headers:{:status=>200}},:status=>:ok

  end

end
