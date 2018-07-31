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
     sleep(1)
     respond_to do |format|
       format.html {super}
       format.json {

         user_email=params[:email]
         password=params[:password]
         user=User.find_by_email(user_email)
         if(!user)
           render :json => {},status: :unauthorized
         elsif user.valid_password?(password)
           render :json =>{Authorization:user.auth_token}, status: :ok
         else
           render :json =>{}, status: :unauthorized
         end
          }

     end

    end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
