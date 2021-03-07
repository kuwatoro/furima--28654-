class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user            #belongs_to :モデル単数形
  has_one :order
  belongs_to :category 
  belongs_to :goods_condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :delivery_time
  has_one_attached :image
  has_many :comments          #has_many :モデル複数形

  validates :name, :goods_explain, presence: true
  validates :category_id, :goods_condition_id, :shipping_fee_id, :prefecture_id, :delivery_time_id, numericality: { other_than: 1 } 
  validates :price, presence: true, numericality: { with: /\A[0-9]+\z/ , message: 'half-width'}
  validates_inclusion_of :price, in: 300..9_999_999, message:"out of range"
  validates :image, presence: true
end
