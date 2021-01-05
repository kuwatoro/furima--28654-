class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :items
  has_many :order
  
  validates :nickname, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: true }
  validates :password, presence: true, length: { minimum: 6 }, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }, confirmation: true
  validates :surname_kanji, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :name_kanji, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :surname_katakana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :name_katakana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :birthday, presence: true
end
