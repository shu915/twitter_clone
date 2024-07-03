# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

users = [
  { account_name: 'user1', display_name: 'user1', email: 'chukichi915@gmail.com',
    tel: '1234567890', birthday: '2000-01-01', password: 'password1' },
  { account_name: 'user2', display_name: 'user2', email: 'shu915.web.creation@gmail.com',
    tel: '9876543210', birthday: '2000-02-02', password: 'password2' },
  { account_name: 'user3', display_name: 'user3', email: 'uhs915@gmail.com',
    tel: '5555555555', birthday: '2000-03-03', password: 'password3' }
]

users.each do |user_data|
  user = User.find_or_create_by(email: user_data[:email]) do |u|
    u.account_name = user_data[:account_name]
    u.display_name = user_data[:display_name]
    u.tel = user_data[:tel]
    u.birthday = user_data[:birthday]
    u.password = user_data[:password]
    u.location = '東京都渋谷区'
    u.url = 'https://shu-web-creation.com'
    u.self_intro =
      'Webデザイナーの山田花子です。東京出身、28歳。ユーザー目線のデザインを心がけています。
    旅行と写真撮影が趣味。インスピレーションを大切にしながら、これからも成長を続けていきます。よろしくお願いします！'
    u.skip_confirmation!
    u.save!
  end

  # ユーザーごとにツイートを作成
  tweets = 11.times.map do |i|
    Tweet.create(user_id: user.id, content: "ツイートその #{i + 1} by #{user.email}")
  end

  # いいね
  user.liked_tweets << tweets[0..1]

  # リツイート
  user.retweeted_tweets << tweets[2..3]

  # コメント
  # user.tweets.create(content: '返信1', parent_id: tweets[4].id)
  # user.tweets.create(content: '返信2', parent_id: tweets[5].id)

  Notice.create(sender: user, receiver: user, notice_type: 1, like: user.likes.first)
end

# フォロー関係
user1, user2, user3 = User.all
user1.followings << user2
user1.followings << user3
user2.followings << user3
