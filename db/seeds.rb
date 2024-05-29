# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

users = [
  { email: 'user1@example.com', tel: '1234567890', birthday: '2000-01-01', password: 'password1' },
  { email: 'user2@example.com', tel: '9876543210', birthday: '2000-02-02', password: 'password2' },
  { email: 'user3@example.com', tel: '5555555555', birthday: '2000-03-03', password: 'password3' }
]

users.each do |user_data|
  user = User.find_or_create_by(email: user_data[:email]) do |u|
    u.tel = user_data[:tel]
    u.birthday = user_data[:birthday]
    u.password = user_data[:password]
    u.location = '東京都渋谷区'
    u.url = 'https://shu-web-creation.com'
    u.self_intro = 'Webデザイナーの山田花子です。東京出身、28歳。ユーザー目線のデザインを心がけています。 旅行と写真撮影が趣味。インスピレーションを大切にしながら、これからも成長を続けていきます。よろしくお願いします！'
    u.skip_confirmation!
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
  user.comments.create(content: 'コメント1', tweet: tweets[4])
  user.comments.create(content: 'コメント2', tweet: tweets[5])
end

# フォロー関係
user1, user2, user3 = User.all
user1.followings << user2
user1.followings << user3
user2.followings << user3
