class Photo < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :title, presence: { message: "タイトルを入力してください" },
                    length: { maximum: 30, message: "タイトルは30文字以内で入力してください" }
  validates :image, presence: { message: "画像ファイルを選択してください" }
end
