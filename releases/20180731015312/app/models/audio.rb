class Audio < ApplicationRecord
  has_attached_file :audio

  validates_attachment_content_type :audio,:content_type => /\Aaudio/
end
