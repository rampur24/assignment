class Userpost < ApplicationRecord
  mount_uploader :image, ImageUploader
end
