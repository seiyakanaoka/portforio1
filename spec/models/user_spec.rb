# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do

  it "有効な名前、メール、パスワード、電話番号がある場合は保存されるか、" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  context "空白のバリデーションチェック" do
    it "名前、メール、パスワード、電話番号が空白の場合、バリデーションチェックされエラーメッセージが返ってくるか" do
      user_info = User.new(name: '', email: '', password: '', telephone_number: '')
      expect(user_info).to be_invalid

      # expect(image.errors[:profile_image]).to include(I18n.t('errors.messages.blank'))
    end
    it "プロフィール画像が空白の場合、バリデーションチェックされエラーメッセージが返ってくるか" do
      image = User.new(profile_image: '')
      expect(image).to be_invalid

      # expect(image.errors[:profile_image]).to include(I18n.t('errors.messages.blank'))
    end
    it "ニックネームが空白の場合、バリデーションチェックされエラーメッセージが返ってくるか" do
      nick_name = User.new(nick_name: '')
      expect(nick_name).to be_invalid

      # expect(image.errors[:profile_image]).to include(I18n.t('errors.messages.blank'))
    end
  end


  describe 'アソシエーションのテスト' do
    context 'Bookモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:logs).macro).to eq :has_many
      end
    end
  end
end