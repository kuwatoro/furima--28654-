require 'rails_helper'
describe User do
  before do
    @order_residence = FactoryBot.build(:order_residence)
  end

  describe '商品の購入' do
    context '商品が購入できるとき' do
      it "zip_code、prefecture_id、municipality、street_number、telephone_number、tokenが存在すれば登録できる" do
        expect(@order_residence).to be_valid
      end

      it "zip_codeがハイフンありの7桁であれば登録できる" do
        @order_residence.zip_code = "123-4567"
        expect(@order_residence).to be_valid
      end
      
      it "telephone_numberがハイフン無しの11桁以内であれば登録できる" do
        @order_residence.telephone_number = "09012345678"
        expect(@order_residence).to be_valid
      end
    end

    context '商品が購入できないとき' do
      it "zip_codeが空だと登録できない" do
        @order_residence.zip_code = ""
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("Zip code can't be blank")
      end

      it "zip_codeが全角だと登録できない" do
        @order_residence.zip_code = "１２３−４５６７"
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("Zip code is invalid")
      end

      it "zip_codeがハイフン無しだと登録できない" do
        @order_residence.zip_code = "1234567"
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("Zip code is invalid")
      end

      it "zip_codeが7桁以外だと登録できない" do
        @order_residence.zip_code = "123-45678"
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("Zip code is invalid")
      end

      it "prefecture_idが空だと登録できない" do
        @order_residence.prefecture_id = ""
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("Prefecture is not a number")
      end

      it "prefecture_idが1（空の状態）だと登録できない" do
        @order_residence.prefecture_id = 1
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("Prefecture must be other than 1")
      end
      
      it "municipalityが空だと登録できない" do
        @order_residence.municipality = ""
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("Municipality can't be blank")
      end
      
      it "street_numberが空だと登録できない" do
        @order_residence.street_number = ""
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("Street number can't be blank")
      end
      
      it "telephone_numberが空だと登録できない" do
        @order_residence.telephone_number = ""
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("Telephone number can't be blank")
      end
      
      it "telephone_numberが半角数字以外だと登録できない" do
        @order_residence.telephone_number = "０９０１２３４５６７８"
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("Telephone number is not a number")
      end

      it "telephone_numberがハイフン有りだと登録できない" do
        @order_residence.telephone_number = "090-1234-5678"
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("Telephone number is not a number")
      end

      it "tokenが空だと登録できない" do
        @order_residence.token = ""
        @order_residence.valid?
        expect(@order_residence.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
