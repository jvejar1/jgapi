# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  skip_before_action :verify_authenticity_token
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
   def create
     respond_to do |format|
       format.html {super}
       format.json {
         user_email=params[:email]
         password=params[:password]
         user=User.find_by_email(user_email)
         if(!user)
           render :json => {'message': 'user not found'},status: :unauthorized
         elsif user.valid_password?(password)
          
          payload = {
            user:{
              id: user.id,
              email: user.email
              }
            }
          token = JWT.encode(payload, nil, 'none')
          render :json =>{Authorization:user.auth_token,user_id:user.id, jwt: token,status: 200}, status: :ok
         else
           render :json =>{'messsage': 'user password wrong'}, status: :unauthorized
         end
          }

     end

    end

  # DELETE /resource/sign_out
   def destroy
     super do
       redirect_to root_url, notice: 'Sesión cerrada'
       return
     end


   end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
