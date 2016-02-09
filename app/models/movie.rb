class Movie < ActiveRecord::Base
	searchkick
	belongs_to :user
    has_many :reviews
  has_attached_file :image, styles: { medium: "400x600#"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
#validates_attachment_file_name :image, matches: {matches: [/png\Z/, /jpe?g\Z/, /gif\Z/]}
  # , default_url: "/images/:style/missing.png" // when image is missing
  #, "image/jpeg", "image/png", "image/gif"
 # do_not_validate_attachment_file_type :image
end
