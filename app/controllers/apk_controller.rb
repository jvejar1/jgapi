class ApkController < ApplicationController
  @@apk_path="public/app-release.apk"
  def latest_release
    send_file @@apk_path

  end
end
