# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Logモデルのテスト', type: :model do

  describe 'メソッドの確認' do
    describe 'いいね機能のテスト' do

      context 'ログインユーザーのいいねデータの有無確認' do
        let(:user) { FactoryBot.create(:user) }
        let(:log) { FactoryBot.create(:log, user: user) }

        before do
          user.favorites.create(log_id: log.id)
        end

        it 'Favoriteモデルにログインユーザーのデータが存在する場合' do
          expect(log.favorited_by?(user)).to eq true
        end
        it 'Favoriteモデルにログインユーザーのデータが存在しない場合' do
          user.favorites.find_by(log_id: log.id).destroy
          expect(log.favorited_by?(user)).to eq false
        end
      end

      context 'いいねした時の通知機能の確認' do
        let(:user) { FactoryBot.create(:user) }
        let!(:other_user) { FactoryBot.create(:user) }
        let!(:other_log) { FactoryBot.create(:log, user: other_user) }

        before do
          user.favorites.create(log_id: other_log.id)
        end

        it 'ログインユーザーが他の投稿にいいねした時、通知情報が作成されるか' do
          expect(other_log.create_notification_favorite!(user)).to eq true
        end
      end
    end

    describe 'ブックマーク機能のテスト' do
      let(:user) { FactoryBot.create(:user) }
      let(:log) { FactoryBot.create(:log, user: user) }

      before do
        user.bookmarks.create(log_id: log.id)
      end

      it 'Favoriteモデルにログインユーザーのデータが存在する場合' do
        expect(log.bookmarked_by?(user)).to eq true
      end
      it 'Favoriteモデルにログインユーザーのデータが存在しない場合' do
        user.bookmarks.find_by(log_id: log.id).destroy
        expect(log.bookmarked_by?(user)).to eq false
      end
    end

    describe 'コメントの通知機能のテスト' do
      let(:user) { FactoryBot.create(:user) }
      let!(:other_user) { FactoryBot.create(:user) }
      let!(:other_log) { FactoryBot.create(:log, user: other_user) }

      before do
        other_log.log_comments.create(log_id: other_log.id, user_id: user.id, comment: "test")
      end

      it 'Favoriteモデルにログインユーザーのデータが存在しない場合' do
        expect(other_log.create_notification_comment!(user, user.log_comments)).to eq true
      end
    end
  end

  describe '実際に投稿してみる' do
    subject { log.valid? }

    let(:user) { create(:user) }
    let!(:log) { build(:log, user_id: user.id) }

    context 'log_imageカラム' do
      it '空欄でないこと' do
        log.log_image = ''
        is_expected.to eq false
      end
    end

    context 'weatherカラム' do
      it '空欄でないこと' do
        log.weather = ''
        is_expected.to eq false
      end
    end

    context 'dive_depthカラム' do
      it '空欄でないこと' do
        log.dive_depth = ''
        is_expected.to eq false
      end
    end

    context 'dive_numberカラム' do
      it '空欄でないこと' do
        log.dive_number = ''
        is_expected.to eq false
      end
    end

    context 'dive_pointカラム' do
      it '空欄でないこと' do
        log.dive_point = ''
        is_expected.to eq false
      end
    end

    context 'water_temperatureカラム' do
      it '空欄でないこと' do
        log.water_temperature = ''
        is_expected.to eq false
      end
    end

    context 'titleカラム' do
      it '空欄でないこと' do
        log.address = ''
        is_expected.to eq false
      end
    end

    context 'titleカラム' do
      # it '20文字以下であること: 20文字は〇' do
      #   log.title = Faker::Lorem.characters(number: 20)
      #   # binding.pry
      #   is_expected.to eq true
      # end
      it '20文字以下であること: 21文字は×' do
        log.title = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context 'bodyカラム' do
      # it '150文字以下であること: 150文字は〇' do
      #   log.body = Faker::Lorem.characters(number: 150)
      #   is_expected.to eq true
      # end
      it '150文字以下であること: 151文字は×' do
        log.body = Faker::Lorem.characters(number: 151)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Log.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end