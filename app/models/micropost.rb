class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  # 图像和模型关联
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140}
  validate :picture_size


  private

   #验证上传图像大小
  def picture_size
    if picture.size > 2.megabytes
      errors.add(:picture, "should be less than 2MB")
    end
  end
end
