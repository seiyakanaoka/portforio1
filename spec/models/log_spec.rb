# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Logモデルのテスト', type: :model do

  # describe '実際に投稿してみる' do
  #   let(:user) { create(:user) }
  #   let!(:) { build(:log, user_id: user.id) }
  #   it '有効な投稿の場合は保存されるか' do
  #     log = Log.new(
  #       user_id { user.id },
  #       log_image { 'assets/images/sea-view12.jpg' },
  #       weather { 0 },
  #       dive_depth { 0 },
  #       dive_number { 0 },
  #       dive_point{ 0 },
  #       water_temperature { 0 },
  #       title { Faker::Lorem.characters(number: 10) },
  #       body { Faker::Lorem.characters(number: 100) },
  #       address { Faker::Lorem.characters(number: 20) },
  #       hashbody { Faker::Lorem.characters(number: 10) },
  #       impressions_count { 0 },
  #       latitude { 0 },
  #       longitude { 0 })
  #     expect(log).to be_valid
  #   end
  # end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Log.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end