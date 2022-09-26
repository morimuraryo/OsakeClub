class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# ◆画像を扱えるようにする
has_one_attached :profile_image
# ◆1：Nの関係性
has_many :osakes, dependent: :destroy


 # バリデーション設定
  validates :name, presence: true, uniqueness: true , length: { minimum:2, maximum: 20}
  validates :introduction, length: { maximum: 50}


# ◆画像が存在しない場合no-imagに表示する画像をActiveStrageni格納
# その際、画像を引数でもらいリサイズできるようにしている
def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
end

end
