# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Userモデルのテスト' do
  describe 'バリデーションのテスト' do
    subject { User.valid? }

    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
      it '一意性があること' do
        user.name = other_user.name
        is_expected.to eq false
      end
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