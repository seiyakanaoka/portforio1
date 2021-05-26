require 'rails_helper'

describe '[STEP1] ユーザーログイン前のテスト' do
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
        divin_link = find_all('a')[0].native.inner_text
        divin_link.gsub!(/\n/, '')
        click_link divin_link
        is_expected.to eq '/'
      end
      it 'Log Listを押すと、投稿一覧画面に遷移する' do
        log_list_link = find_all('a')[5].native.inner_text
        # log_list_link = log_list_link.delete(' ')
        log_list_link.gsub!(/\n/, '')
        click_link log_list_link
        is_expected.to eq '/logs'
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

  describe 'ユーザーの新規登録テスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it '「Sign up」と表示される' do
        expect(page).to have_content 'Sign up'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it '電話番号フォームが表示される' do
        expect(page).to have_field 'user[telephone_number]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it 'Sign upボタンが表示される' do
        expect(page).to have_button 'Sign up'
      end
    end

    context '新規登録成功時のテスト' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[telephone_number]', with: Faker::Lorem.characters(number: 11)
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button 'Sign up' }.to change(User.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、新規登録できたユーザーの編集画面になっている' do
        click_button 'Sign up'
        expect(current_path).to eq '/users/' + User.last.id.to_s + '/edit'
      end
    end
  end

  describe 'ユーザーのログインテスト' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end
      it 'Log inと表示される' do
        expect(page).to have_content 'Log in'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'Log inボタンが表示される' do
        expect(page).to have_button 'Log in'
      end
      it 'emailフォームは表示されない' do
        expect(page).not_to have_field 'user[email]'
      end
      it '電話番号フォームは表示されない' do
        expect(page).not_to have_field 'user[telephone_number]'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[name]', with: user.name
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
      end

      it 'ログイン後のリダイレクト先が投稿一覧画面である' do
        expect(current_path).to eq '/logs'
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'user[name]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'Log in'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  describe 'ヘッダーのテスト:　ログインしている場合' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[name]', with: user.name
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
    end

    context 'ヘッダーの表示を確認' do
      it 'ロゴが表示される' do
        expect(page).to have_content 'DivIn'
      end
      it 'Log Listリンク表示される' do
        log_list_link = find_all('a')[8].native.inner_text
        expect(log_list_link).to match(/Log List/)
      end
      it 'New Logリンクが表示される' do
        new_log_link = find_all('a')[9].native.inner_text
        expect(new_log_link).to match(/New Log/)
      end
      it 'Rankingリンクが表示される' do
        ranking_link = find_all('a')[10].native.inner_text
        expect(ranking_link).to match(/Ranking/)
      end
      it 'DM Listリンクが表示される' do
        dm_list_link = find_all('a')[11].native.inner_text
        expect(dm_list_link).to match(/DM List/)
      end
      it 'My Pageリンクが表示される' do
        my_page_link = find_all('a')[12].native.inner_text
        expect(my_page_link).to match(/My Page/)
      end
      it 'Log Outリンクが表示される' do
        log_out_link = find_all('a')[13].native.inner_text
        expect(log_out_link).to match(/Log Out/)
      end
    end
  end

  describe 'ユーザーのログアウトのテスト' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[name]', with: user.name
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
      logout_link = find_all('a')[13].native.inner_text
      logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link logout_link
    end

    context 'ログアウト機能のテスト' do
      it '正しくログアウトできている：　ログアウト後のリダイレクト先においてDM画面へのリンクが存在しない' do
        expect(current_path).not_to have_link '/rooms'
      end
      it '正しくログアウトできている：　ログアウト後のリダイレクト先において新規投稿画面へのリンクが存在しない' do
        expect(current_path).not_to have_link '/logs/new'
      end
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/'
      end
    end
  end
end
