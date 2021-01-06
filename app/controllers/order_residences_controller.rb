class OrderResidencesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  # ユーザがログインしているかどうかを確認し、ログインしていない場合はユーザをログインページにリダイレクトする。
  before_action :set_order_residence, only: [:index, :create]

  def index
    @order_residence = OrderResidence.new
    #ルーティングのネスト。 rails routesをみるとパスが :item_id になっている
    if current_user.id == @item.user_id || @item.order != nil
          # ログインユーザーと出品者が同じ,またはitemの中にorderのデータがある場合
          # どちらかに当てはまればトップページ、当てはまなければ購入ページへ
      redirect_to root_path
    else
      render :index
    end
  end

  def create
    @order_residence = OrderResidence.new(order_residence_params)
    if @order_residence.valid?
      pay_item
      @order_residence.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  
  def order_residence_params
    params.require(:order_residence).permit(:zip_code, :prefecture_id, :municipality, :street_number, :building_name, :telephone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
  Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
  # 自身のPAY.JPテスト秘密鍵を記述して決済できるか確かめる
  # そのあとターミナルで環境変数をシェルに設定し、秘密鍵代入した環境変数を呼び込む
      Payjp::Charge.create(
        amount: @item.price,  # 商品の値段
        card: order_residence_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
        #Payjpは決済のみ。住所などの情報はいらない。
      ) 
  end

  def set_order_residence
    @item = Item.find(params[:item_id])
  end
end

# indexアクション：購入情報入力ページ /items/:id/order_residences
# createアクション：購入処理 /items/:id/order_residences
# @order_residence.valid?
# @order_residence.errors.full_messages
