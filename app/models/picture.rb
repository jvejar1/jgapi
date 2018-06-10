class Picture< ApplicationRecord
  has_attached_file :image,
                    :default_url => '/system/acases/images/original/missing.png',
                    styles: { :small => "280x390#" }
  validates_attachment_content_type :image,
                       content_type: /\Aimage\/.*\z/
end
