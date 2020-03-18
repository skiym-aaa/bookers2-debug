class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # ---フォロー機能---
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  # フォロー取得
  has_many :followings, through: :following_relationships
  # 自分がフォローしている人
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  # フォロワー取得
  has_many :followers, through: :follower_relationships
  # 自分がフォローされている人
  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end

  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end
  # ---ここまで---
  attachment :profile_image, destroy: false

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}
end
