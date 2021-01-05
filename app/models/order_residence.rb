class OrderResidence
  include ActiveModel::Model
  attr_accessor :zip_code, :prefecture_id, :municipality, :street_number, :building_name, :telephone_number, :user_id, :item_id, :token
  # 「住所情報を保存するテーブル」と「購入情報を保存するテーブル」の情報を一度に保する記述をする
  # 住所情報(residences)と購入情報(order_residences)について書いていく

  # 「住所」に関するバリデーション
  with_options presence: true do
    validates :zip_code, format: { with: /\A\d{3}[-]\d{4}\z/} 
    validates :municipality
    validates :street_number
    validates :telephone_number, numericality: { with: /\A\d{10,11}\z/ }
    validates :token
  end
    validates :prefecture_id, numericality: { other_than: 1 }

  def save
  # 購入情報を保存（親）
    order = Order.create(user_id: user_id, item_id: item_id)
  # 住所情報を保存（子）
    Residence.create(zip_code: zip_code, prefecture_id: prefecture_id, municipality: municipality, street_number: street_number, building_name: building_name, telephone_number: telephone_number, order_id: order.id)
  end
  # 「Residence.create」と「Item.create」の中に含まれている「user_id: user.id」ですが、
  # これは「addressesテーブル」と「donationsテーブル」に「user_id」を保存するために記述しています。
  # 直前の記述で「user = User.create〜」とすることで「user」という変数を作り、そのユーザーのidを取得するために「user.id」と記述しています。
end
