class Picture< ApplicationRecord
  has_attached_file :image,
                    :default_url => '/system/acases/images/original/missing.png',
                    styles: { :vertical=> "280x390#",:horizontal=>"450x330#",:squared=>"300x300#" }
  validates_attachment_content_type :image,
                       content_type: /\Aimage\/.*\z/
end
