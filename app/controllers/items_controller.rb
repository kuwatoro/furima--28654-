class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  #ユーザがログインしているかどうかを確認し、ログインしていない場合はユーザをログインページにリダイレクトする。
  before_action :set_item, only: [:edit, :show, :update, :destroy]

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
  end

  def edit
    if current_user.id != @item.user_id
      redirect_to root_path
    end
    # （操作者）が（商品の出品者）と異なる場合 → redirect_to root_path
    # editアクションでは、特に指定しない場合は対応するeditのビューが表示されますので、
    # current_userと出品者が一致した場合のrender :editは省略できます。
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
      # updateアクションでは、商品情報の更新の成功失敗で分岐処理をしていただければと存じます。
      # 商品情報の更新処理をするのは、@item.update(item_params)になりますので、今回はsaveメソッドを使用する必要はございません。
    else
      render :edit
    end
  end

  def destroy
    if current_user.id == @item.user_id
      @item.destroy
    end
    redirect_to root_path  #current_userと出品者が一致してもしなくても、いつでもリダイレクト
  # 悪意のあるユーザーからの攻撃を防ぐため、viewの条件と同様にif文を使用して
  # 「出品したユーザー（とcurrent_userが一致）の場合に削除できる」というコードにしておきましょう。
  # （ビューでは検証ツールを使用すると削除ボタンを作成できてしまうため）
  end
  
  private

  def item_params
    params.require(:item).permit(:name, :image, :goods_explain, :category_id, :goods_condition_id, :shipping_fee_id, :prefecture_id, :delivery_time_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
