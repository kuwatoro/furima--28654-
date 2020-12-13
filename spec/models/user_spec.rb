require 'rails_helper'
describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it "nickname、email、passwordとpassword_confirmation、surname_kanji、name_kanji、surname_katakana、name_katakana、birthdayが存在すれば登録できる" do
        expect(@user).to be_valid
      end
      it "emailに@が入っていれば登録できる" do
        @user.email = "abc@abc"
        expect(@user).to be_valid
      end
      it "passwordが半角英数字混合かつ６文字以上であれば登録できる" do
        @user.password = "abc123"
        @user.password_confirmation = "abc123"
        expect(@user).to be_valid
      end
      it "surname_kanjiが全角（漢字、ひらがな、カタカナ）であれば登録できる" do
        @user.surname_kanji = "花京院"
        expect(@user).to be_valid
      end
      it "name_kanjiが全角（漢字、ひらがな、カタカナ）であれば登録できる" do
        @user.name_kanji = "典明"
        expect(@user).to be_valid
      end
      it "surname_katakanaが全角（カタカナ）であれば登録できる" do
        @user.surname_katakana = "カキョウイン"
        expect(@user).to be_valid
      end
      it "name_katakanaが全角（カタカナ）であれば登録できる" do
        @user.name_katakana = "ノリアキ"
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it "nicknameが空だと登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空だと登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "emailに@が入っていない場合登録できない" do
        @user.email = "abcabc"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "重複したemailが存在する場合登録できない" do
        @user.save
        stand_user = FactoryBot.build(:user)
        stand_user.email = @user.email
        stand_user.valid?
      end
      it "passwordが空だと登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordが5文字以下だと登録できない" do
        @user.password = "abc12"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "passwordが半角英数字以外だと登録できない" do
        @user.password = "あいうえおか"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "passwordが半角英字のみだと登録できない" do
        @user.password = "abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "passwordが半角数字のみだと登録できない" do
        @user.password = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "surname_kanjiが空だと登録できない" do
        @user.surname_kanji = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Surname kanji can't be blank")
      end
      it "surname_kanjiが全角（漢字、ひらがな、カタカナ）以外だと登録できない" do
        @user.surname_kanji = "kakyouinn"
        @user.valid?
        expect(@user.errors.full_messages).to include("Surname kanji is invalid")
      end
      it "name_kanjiが空だと登録できない" do
        @user.name_kanji = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kanji can't be blank")
      end
      it "name_kanjiが全角（漢字、ひらがな、カタカナ）以外だと登録できない" do
        @user.name_kanji = "noriaki"
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kanji is invalid")
      end
      it "surname_katakanaが空だと登録できない" do
        @user.surname_katakana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Surname katakana can't be blank")
      end
      it "surname_katakanaが全角（カタカナ）以外だと登録できない" do
        @user.surname_katakana = "kakyouinn"
        @user.valid?
        expect(@user.errors.full_messages).to include("Surname katakana is invalid")
      end
      it "name_katakanaが空だと登録できない" do
        @user.name_katakana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Name katakana can't be blank")
      end
      it "name_katakanaが全角（カタカナ）以外だと登録できない" do
        @user.name_katakana = "noriaki"
        @user.valid?
        expect(@user.errors.full_messages).to include("Name katakana is invalid")
      end
      it "birthdayが空だと登録できない" do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
