class AudiosController < ApplicationController
skip_before_action :authenticate_user!
  def download
    audio=Audio.find(params[:id])
    file_path=audio.audio.path
    send_file file_path,:disposition => 'attachment',:type=>audio.audio_content_type

  end

end
