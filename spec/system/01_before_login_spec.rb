require 'rails_helper'

describe '[STEP1] ユーザーログイン前のテスト'do

  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it 'ハンバーガーメニュー内にLog Listが表示される: 上から1番目のリンクである' do
        sign_up_link = find_all('a')[5].native.inner_text
        expect(sign_up_link).to match(/Log List/)
      end
      it 'Log Listのリンク内容が正しい' do
        log_list_link = find_all('a')[5].native.inner_text
        expect(page).to have_link log_list_link, href: logs_path
      end
      it 'ハンバーガーメニュー内にRankingが表示される: 上から2番目のリンクである' do
        ranking_link = find_all('a')[6].native.inner_text
        expect(ranking_link).to match(/Ranking/)
      end
      it 'Rankingのリンクの内容が正しい' do
        ranking_link = find_all('a')[6].native.inner_text
        expect(page).to have_link ranking_link, href: ranks_path
      end
      it 'ハンバーガーメニュー内にサインアップリンクアイコンが表示される: 上から3番目のリンクである' do
        sign_up_link = find_all('a')[7].native.inner_text
        expect(sign_up_link).to match(/Sign Up/)
      end
      it 'サインアップリンクの内容が正しい' do
        sign_up_link = find_all('a')[7].native.inner_text
        expect(page).to have_link sign_up_link, href: new_user_registration_path
      end
      it 'ハンバーガーメニュー内にログインリンクが表示される: 上から4番目のリンクである' do
        log_in_link = find_all('a')[8].native.inner_text
        expect(log_in_link).to match(/Sign In/)
      end
      it 'ログインリンクの内容が正しい' do
        log_in_link = find_all('a')[8].native.inner_text
        expect(page).to have_link log_in_link, href: new_user_session_path
      end
      it 'ハンバーガーメニュー内にサインアップリンクアイコンが表示される: 上から3番目のリンクである' do
        guest_sign_in_link = find_all('a')[9].native.inner_text
        expect(guest_sign_in_link).to match(/Guest/)
      end
      it 'サインアップリンクの内容が正しい' do
        guest_sign_in_link = find_all('a')[9].native.inner_text
        expect(page).to have_link guest_sign_in_link, href: users_guest_sign_in_path
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'タイトルが表示される' do
        expect(page).to have_content 'DivIn'
      end
    end

    context 'リンクの内容を確認' do
      subject { current_path }

      it 'ロゴを押すと、トップページに遷移する' do
        divin_link = find_all('a')[4].native.inner_text
        divin_link = divin_link.delete(' ')
        divin_link.gsub!(/\n/, '')
        click_link divin_link
        is_expected.to eq '/'
      end
      it 'Log Listを押すと、投稿一覧画面に遷移する' do
        log_list_link = find_all('a')[5].native.inner_text
        # log_list_link = log_list_link.delete(' ')
        log_list_link.gsub!(/\n/, '')
        binding.pry
        click_link log_list_link
        is_expected.to eq 'logs/index'
      end
      # it 'Rankingを押すと、ランキング画面に遷移する' do
      #   ranking_link = find_all('a')[6].native.inner_text
      #   ranking_link = ranking_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      #   click_link ranking_link
      #   is_expected.to eq '/ranks/index'
      # end
      it 'sign upを押すと、新規登録画面に遷移する' do
        signup_link = find_all('a')[7].native.inner_text
        signup_link = signup_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link signup_link
        is_expected.to eq '/users/sign_up'
      end
      it 'loginを押すと、ログイン画面に遷移する' do
        login_link = find_all('a')[8].native.inner_text
        login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link login_link
        is_expected.to eq '/users/sign_in'
      end
    end
  end

end