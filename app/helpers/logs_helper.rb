module LogsHelper
  def render_with_hashtags(hashbody)
    # gsubで(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)を検索した後、{}の部分で、持ってきた情報にリンクを付加させエスケープ処理せずに置換する
    # ※DELETEメソッドがあるが、表示される時ではなく、リンク先のルーティングを指定する際に＃が邪魔になるから削除している
    hashbody.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/log/hashtag/#{word.delete("#")}",data: {"turbolinks" => false} }.html_safe
  end
end
