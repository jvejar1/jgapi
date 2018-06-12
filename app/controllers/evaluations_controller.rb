class EvaluationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  def create

    sleep(3)

    render json:{request_id_to_delete:params[:request_id_to_delete],headers:{:status=>200}},:status=>:ok

  end

end
