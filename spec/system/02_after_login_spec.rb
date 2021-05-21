require 'rails_helper'

describe '[STEP2] ユーザーログイン後のテスト' do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:log) { create(:log, user: user) }
  let!(:other_log) { create(:log, user: other_user) }

  before do
    visit new_user_session_path
    fill_in 'user[name]', with: user.name
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  describe 'ヘッダーのテスト：　ログインしている場合' do
    context 'リンクの内容を確認：　※Log Outは『ユーザーログアウトのテスト』でテスト済み' do
      subject { current_path }

      it 'Divinを押すとトップ画面に遷移する' do
        divin_link = find_all('a')[0].native.inner_text
        divin_link = divin_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link divin_link
        is_expected.to eq '/'
      end
      it 'Log Listを押すと投稿一覧画面に遷移する' do
        log_list_link = find_all('a')[8].native.inner_text
        log_list_link = log_list_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link log_list_link
        is_expected.to eq '/logs'
      end
      it 'New Logを押すと新規投稿画面に遷移する' do
        new_log_link = find_all('a')[9].native.inner_text
        new_log_link = new_log_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link new_log_link
        is_expected.to eq '/logs/new'
      end
      # it 'Rankingを押すとランキング画面に遷移する' do
      #   ranking_link = find_all('a')[10].native.inner_text
      #   ranking_link = ranking_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      #   click_link ranking_link
      #   is_expected.to eq '/'
      # end
      it 'DM Listを押すとDM一覧画面に遷移する' do
        dm_list_link = find_all('a')[11].native.inner_text
        dm_list_link = dm_list_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link dm_list_link
        is_expected.to eq '/rooms'
      end
      it 'My Pageを押すとマイページ画面に遷移する' do
        mypage_link = find_all('a')[12].native.inner_text
        mypage_link = mypage_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link mypage_link
        is_expected.to eq '/users/' + user.id.to_s + '/my_page'
      end
    end
  end

  describe '投稿一覧画面のテスト' do
    before do
      visit logs_path
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/logs'
      end
      # it '自分の画像のリンク先が正しい' do
      #   # binding.pry
      #   expect(page).to have_link '', href: user_path(log.user)
      # end
      it '他人の画像のリンク先が正しい' do
        expect(page).to have_link '', href: user_path(other_log.user)
      end
      # it '新規投稿ボタンのリンク先が正しい' do
      #   expect(page).to have_link '投稿する'
      # end
      it '自分の投稿と他人の投稿の画像のリンク先がそれぞれ正しい' do
        expect(page).to have_link '', href: log_path(log)
        expect(page).to have_link '', href: log_path(other_log)
      end
      # it '自分の投稿と他人の投稿の画像が表示される' do
      #   expect(page).to have_content log.log_image
      #   expect(page).to have_content other_log.log_image
      # end
      it '自分の投稿と他人の投稿のタイトルが表示される' do
        expect(page).to have_content log.title
        expect(page).to have_content other_log.title
      end
      it '自分の投稿と他人の投稿の住所が表示される' do
        expect(page).to have_content log.dive_point
        expect(page).to have_content other_log.dive_point
      end
      it 'サイドバーが表示される' do
        expect(page).to have_content 'My Profile'
      end
      it '自分のニックネームが表示される' do
        expect(page).to have_content user.nick_name
      end
    end
  end

  describe '投稿詳細画面のテスト' do
    before do
      visit log_path(log.id)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/logs/' + log.id.to_s
      end
      it '投稿タイトルが表示される' do
        expect(page).to have_content log.title
      end
      it '投稿内容が表示される' do
        expect(page).to have_content log.body
      end
      it '天気が表示される' do
        expect(page).to have_content log.weather
      end
      it '水温が表示される' do
        expect(page).to have_content log.water_temperature
      end
      it '潜水深度が表示される' do
        expect(page).to have_content log.dive_depth
      end
      it '潜水本数が表示される' do
        expect(page).to have_content log.dive_number
      end
      it 'ダイブポイントが表示される' do
        expect(page).to have_content log.dive_point
      end
      # it '投稿画像が表示される' do
      #   expect(page).to have_content log.log_image
      # end
      it 'ハッシュタグが表示される' do
        expect(page).to have_content log.hashbody
      end
      it 'ダイビング場所の住所が表示される' do
        expect(page).to have_content log.address
      end
    end
  end

  describe '新規投稿画面のテスト' do
    before do
    visit new_log_path
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/logs/new'
      end
      it '画像投稿フォームがある' do
        expect(page).to have_field 'log[log_image]'
      end
      it '天気投稿フォームがある' do
        expect(page).to have_field 'log[weather]'
      end
      it '水温投稿フォームがある' do
        expect(page).to have_field 'log[water_temperature]'
      end
      it '潜水深度投稿フォームがある' do
        expect(page).to have_field 'log[dive_depth]'
      end
      it '潜水本数投稿フォームがある' do
        expect(page).to have_field 'log[dive_number]'
      end
      it 'ダイビングポイント投稿フォームがある' do
        expect(page).to have_field 'log[dive_point]'
      end
      it 'タイトル投稿フォームがある' do
        expect(page).to have_field 'log[title]'
      end
      it '内容投稿フォームがある' do
        expect(page).to have_field 'log[body]'
      end
      it 'タグ付け投稿フォームがある' do
        expect(page).to have_field 'log[hashbody]'
      end
      it '住所投稿フォームがある' do
        expect(page).to have_field 'log[address]'
      end
      it '画像投稿フォームがある' do
        expect(page).to have_button '投稿'
      end
    end

    # context '投稿成功のテスト' do
    #   before do
    #     # fill_in 'log[log_image]', with: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sea-view12.jpg'
    #     select "☀️" , from: 'log[weather]'
    #     select 1 , from: 'log[water_temperature]'
    #     select 1 , from: 'log[dive_depth]'
    #     select 1 , from: 'log[dive_number]'
    #     fill_in 'log[dive_point]', with: Faker::Lorem.characters(number: 10)
    #     fill_in 'log[title]', with: Faker::Lorem.characters(number: 10)
    #     fill_in 'log[body]', with: Faker::Lorem.characters(number: 120)
    #     fill_in 'log[hashbody]', with: Faker::Lorem.characters(number: 10)
    #     fill_in 'log[address]', with: Faker::Lorem.characters(number: 20)
    #   end

    #   it '自分の新しい投稿が正しく保存される' do
    #     binding.pry
    #     expect { click_button '投稿' }.to change(user.logs, :count).by(1)
    #   end
    #   it 'リダイレクト先が、投稿一覧画面になっている' do
    #     click_button '投稿'
    #     expect(current_path).to eq '/logs'
    #   end
    # end
  end
end