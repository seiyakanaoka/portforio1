# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Logモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { log.valid? }

    let(:user) { create(:user) }
    let!(:log) { build(:log, user_id: user.id) }

    context 'log_imageカラム' do
      it '空でないこと' do
        log.log_image = nil
        is_expected.to eq false
      end
    end

    context 'weatherカラム' do
      it '空欄でないこと' do
        log.weather = nil
        is_expected.to eq false
      end
    end

    context 'dive_depthカラム' do
      it '空欄でないこと' do
        log.dive_depth = nil
        is_expected.to eq false
      end
    end

    context 'dive_numbeカラムr' do
      it '空欄でないこと' do
        log.dive_number = nil
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
      it '12文字以下であること:12文字は◯' do
        log.title = Faker::Lorem.characters(number: 12)
        is_expected.to eq true
      end
      it '12文字以下であること：13文字は×' do
        log.title = Faker::Lorem.characters(number: 13)
        is_expected.to eq false
      end
    end

    context 'bodyカラム' do
      it '150文字以下であること：150文字は◯' do
        log.body = Faker::Lorem.characters(number: 150)
        is_expected.to eq true
      end
      it '150文字以下であること：151文字は×' do
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