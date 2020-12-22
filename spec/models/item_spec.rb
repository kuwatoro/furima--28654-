require 'rails_helper'
describe User do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品の出品' do
    context '出品がうまくいくとき' do
      it "name、image、goods_explain、category_id、goods_condition_id、shipping_fee_id、prefecture_id、delivery_time_id、priceが存在すれば登録できる" do
        expect(@item).to be_valid
      end
      it "priceが半角数字かつ300~9999999の範囲内であれば登録できる" do
        @item.price = 32000
        expect(@item).to be_valid
      end
    end

    context '出品がうまくいかないとき' do
      it "imageが空だと登録できない" do
        @item.image = nil
        @item.valid? 
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it "nameが空だと登録できない" do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it "goods_explainが空だと登録できない" do
        @item.goods_explain = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Goods explain can't be blank")
      end
      it "category_idが空だと登録できない" do
        @item.category_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Category is not a number")
      end
      it "category_idが1（空の状態）だと登録できない" do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end
      it "goods_condition_idが空だと登録できない" do
         @item.goods_condition_id = ""
         @item.valid?
        expect(@item.errors.full_messages).to include("Goods condition is not a number")
      end
      it "goods_condition_idが1（空の状態）だと登録できない" do
        @item.goods_condition_id = 1
        @item.valid?
       expect(@item.errors.full_messages).to include("Goods condition must be other than 1")
     end
      it "shipping_fee_idが空だと登録できない" do
        @item.shipping_fee_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee is not a number")
      end
      it "shipping_fee_idが1（空の状態）だと登録できない" do
        @item.shipping_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee must be other than 1")
      end
      it "prefecture_idが空だと登録できない" do
        @item.prefecture_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture is not a number")
      end
      it "prefecture_idが1（空の状態）だと登録できない" do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it "delivery_time_idが空だと登録できない" do
        @item.delivery_time_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery time is not a number")
      end
      it "delivery_time_idが1（空の状態）だと登録できない" do
        @item.delivery_time_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery time must be other than 1")
      end
      it "priceが空だと登録できない" do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it "priceが300以下だと登録できない" do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price out of range")
      end
      it "priceが9999999以上だと登録できない" do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price out of range")
      end
      it "priceが半角数字以外だと登録できない" do
        @item.price = "abc"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price half-width")
      end
    end
  end
end
