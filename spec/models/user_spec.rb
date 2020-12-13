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
        @user = User.new(nickname: "", email: "abc@abc", password: "abc123", password_confirmation: "abc123", surname_kanji: "花京院", name_kanji: "典明", surname_katakana: "カキョウイン", name_katakana: "ノリアキ", birthday: "1999.01.13")
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空だと登録できない" do
        @user = User.new(nickname: "rerorerorero", email: "", password: "abc123", password_confirmation: "abc123", surname_kanji: "花京院", name_kanji: "典明", surname_katakana: "カキョウイン", name_katakana: "ノリアキ", birthday: "1999.01.13")
        @user.valid?
        expect(@user.errors.full_messages).to include("Email cant be blank")
      end
      it "emailに@が入っていない場合登録できない" do
        @user = User.new(nickname: "rerorerorero", email: "abcabc", password: "abc123", password_confirmation: "abc123", surname_kanji: "花京院", name_kanji: "典明", surname_katakana: "カキョウイン", name_katakana: "ノリアキ", birthday: "1999.01.13")
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
        @user = User.new(nickname: "rerorerorero", email: "abc@abc", password: "", password_confirmation: "abc123", surname_kanji: "花京院", name_kanji: "典明", surname_katakana: "カキョウイン", name_katakana: "ノリアキ", birthday: "1999.01.13")
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordが5文字以下だと登録できない" do
        @user = User.new(nickname: "rerorerorero", email: "abc@abc", password: "abc12", password_confirmation: "abc123", surname_kanji: "花京院", name_kanji: "典明", surname_katakana: "カキョウイン", name_katakana: "ノリアキ", birthday: "1999.01.13")
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "passwordが半角英数字以外だと登録できない" do
        @user = User.new(nickname: "rerorerorero", email: "abc@abc", password: "あいうえお", password_confirmation: "abc123", surname_kanji: "花京院", name_kanji: "典明", surname_katakana: "カキョウイン", name_katakana: "ノリアキ", birthday: "1999.01.13")
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "passwordが半角英字のみだと登録できない" do
        @user = User.new(nickname: "rerorerorero", email: "abc@abc", password: "abcdef", password_confirmation: "abc123", surname_kanji: "花京院", name_kanji: "典明", surname_katakana: "カキョウイン", name_katakana: "ノリアキ", birthday: "1999.01.13")
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "passwordが半角数字のみだと登録できない" do
        @user = User.new(nickname: "rerorerorero", email: "abc@abc", password: "123456", password_confirmation: "abc123", surname_kanji: "花京院", name_kanji: "典明", surname_katakana: "カキョウイン", name_katakana: "ノリアキ", birthday: "1999.01.13")
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user = User.new(nickname: "rerorerorero", email: "abc@abc", password: "abc123", password_confirmation: "", surname_kanji: "花京院", name_kanji: "典明", surname_katakana: "カキョウイン", name_katakana: "ノリアキ", birthday: "1999.01.13")
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "surname_kanjiが空だと登録できない" do
        @user = User.new(nickname: "rerorerorero", email: "abc@abc", password: "abc123", password_confirmation: "abc123", surname_kanji: "", name_kanji: "典明", surname_katakana: "カキョウイン", name_katakana: "ノリアキ", birthday: "1999.01.13")
        @user.valid?
        expect(@user.errors.full_messages).to include("Surname kanji can't be blank")
      end
      it "surname_kanjiが全角（漢字、ひらがな、カタカナ）以外だと登録できない" do
        @user = User.new(nickname: "rerorerorero", email: "abc@abc", password: "abc123", password_confirmation: "abc123", surname_kanji: "kakyouinn", name_kanji: "典明", surname_katakana: "カキョウイン", name_katakana: "ノリアキ", birthday: "1999.01.13")
        @user.valid?
        expect(@user.errors.full_messages).to include("Surname kanji is invalid")
      end
      it "name_kanjiが空だと登録できない" do
        @user = User.new(nickname: "rerorerorero", email: "abc@abc", password: "abc123", password_confirmation: "abc123", surname_kanji: "花京院", name_kanji: "", surname_katakana: "カキョウイン", name_katakana: "ノリアキ", birthday: "1999.01.13")
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kanji can't be blank")
      end
      it "name_kanjiが全角（漢字、ひらがな、カタカナ）以外だと登録できない" do
        @user = User.new(nickname: "rerorerorero", email: "abc@abc", password: "abc123", password_confirmation: "abc123", surname_kanji: "花京院", name_kanji: "noriaki", surname_katakana: "カキョウイン", name_katakana: "ノリアキ", birthday: "1999.01.13")
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kanji is invalid")
      end
      it "surname_katakanaが空だと登録できない" do
        @user = User.new(nickname: "rerorerorero", email: "abc@abc", password: "abc123", password_confirmation: "abc123", surname_kanji: "花京院", name_kanji: "典明", surname_katakana: "", name_katakana: "ノリアキ", birthday: "1999.01.13")
        @user.valid?
        expect(@user.errors.full_messages).to include("Surname katakana can't be blank")
      end
      it "surname_katakanaが全角（カタカナ）以外だと登録できない" do
        @user = User.new(nickname: "rerorerorero", email: "abc@abc", password: "abc123", password_confirmation: "abc123", surname_kanji: "花京院", name_kanji: "典明", surname_katakana: "kakyouinn", name_katakana: "ノリアキ", birthday: "1999.01.13")
        @user.valid?
        expect(@user.errors.full_messages).to include("Surname kanji is invalid")
      end
      it "name_katakanaが空だと登録できない" do
        @user = User.new(nickname: "rerorerorero", email: "abc@abc", password: "abc123", password_confirmation: "abc123", surname_kanji: "花京院", name_kanji: "典明", surname_katakana: "カキョウイン", name_katakana: "", birthday: "1999.01.13")
        @user.valid?
        expect(@user.errors.full_messages).to include("Name katakana can't be blank")
      end
      it "name_katakanaが全角（カタカナ）以外だと登録できない" do
        @user = User.new(nickname: "rerorerorero", email: "abc@abc", password: "abc123", password_confirmation: "abc123", surname_kanji: "花京院", name_kanji: "典明", surname_katakana: "カキョウイン", name_katakana: "noriaki", birthday: "1999.01.13")
        @user.valid?
        expect(@user.errors.full_messages).to include("Name katakana is invalid")
      end
      it "birthdayが空だと登録できない" do
        @user = User.new(nickname: "rerorerorero", email: "abc@abc", password: "abc123", password_confirmation: "abc123", surname_kanji: "花京院", name_kanji: "典明", surname_katakana: "カキョウイン", name_katakana: "典明", birthday: "")
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
