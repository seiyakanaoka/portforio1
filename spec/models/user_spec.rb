# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'メソッドの確認' do
    describe '退会機能の確認' do
      let(:user) { FactoryBot.create(:user) }
      before do
        user.update(is_deleted: true)
      end

      it 'ユーザーは正常に退会処理された後、ログインすることは不可能か' do
        expect(user.active_for_authentication?).to eq false
      end
    end

    describe 'フォロー機能の動作確認' do
      let(:user) { FactoryBot.create(:user) }
      let(:other_user) { FactoryBot.create(:user) }

      context '相手をフォローする動作の確認' do
        before do
          user.follow(other_user.id)
        end

        it 'ログインユーザーが、他のユーザをフォローできているか' do
          expect(user.following?(other_user)).to be_truthy
        end
      end

      context 'フォロー解除の動作確認' do
        before do
          user.follow(other_user.id)
        end

        it 'ログインユーザーが、フォローしているユーザーのフォローを解除ができるか' do
          user.unfollow(other_user.id)
          expect(user.following?(other_user)).to be_falsy
        end
      end

      context 'フォロー時の通知機能の確認' do
        before do
          user.follow(other_user.id)
        end

        it 'ログインユーザーが他のユーザをフォローした時、通知情報が作成されるか' do
          expect(other_user.create_notification_follow!(user)).to eq true
        end
      end
    end
  end

  it '有効な名前、メール、パスワード、電話番号がある場合は保存されるか、' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  context '空白のバリデーションチェック' do
    it '名前、メール、パスワード、電話番号が空白の場合、バリデーションチェックされエラーメッセージが返ってくるか' do
      user_info = User.new(name: '', email: '', password: '', telephone_number: '')
      expect(user_info).to be_invalid
    end
    it 'プロフィール画像が空白の場合、バリデーションチェックされエラーメッセージが返ってくるか' do
      image = User.new(profile_image: '')
      expect(image).to be_invalid
    end
    it 'ニックネームが空白の場合、バリデーションチェックされエラーメッセージが返ってくるか' do
      nick_name = User.new(nick_name: '')
      expect(nick_name).to be_invalid
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
