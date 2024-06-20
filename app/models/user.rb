# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  tel                    :string           not null
#  birthday               :date             not null
#  account_name           :string           not null
#  display_name           :string           not null
#  location               :string           default("非公開")
#  url                    :string
#  self_intro             :text
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable, :omniauthable, omniauth_providers: %i[github]
  has_many :authorizations, dependent: :destroy

  has_many :active_relationships, class_name: 'Follow', foreign_key: 'following_id', dependent: :destroy,
                                  inverse_of: :following
  has_many :followings, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: 'Follow', foreign_key: 'followed_id', dependent: :destroy,
                                   inverse_of: :followed
  has_many :followeds, through: :passive_relationships, source: :following

  has_many :tweets, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet

  has_many :retweets, dependent: :destroy
  has_many :retweeted_tweets, through: :retweets, source: :tweet

  has_many :comments, dependent: :destroy

  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_tweets, through: :bookmarks, source: :tweet

  has_one_attached :avatar
  has_one_attached :header_image

  validates :tel, presence: true, length: { maximum: 20 }, numericality: { only_integer: true }
  validates :birthday, presence: true,
                       format: { with: /\A\d{4}-\d{1,2}-\d{1,2}\z/, message: 'は「YYYY-MM-DD」の形式で入力してください' }

  validates :account_name, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :display_name, presence: true, length: { maximum: 20 }
  validates :location, length: { maximum: 25 }
  validates :url, length: { maximum: 255 },
                  format: { with: %r{\A(https?://)}i, message: 'は有効ではありません', allow_blank: true }
  validates :self_intro, length: { maximum: 500 }

  validates :avatar, content_type: { in: %i[png jpg jpeg webp], message: 'はpng, jpeg, jpg, webpのいずれかにしてください' },
                     size: { less_than: 5.megabytes }
  validates :header_image, content_type: { in: %i[png jpg jpeg webp], message: 'はpng, jpeg, jpg, webpのいずれかにしてください' },
                           size: { less_than: 5.megabytes }

  after_create :attach_default_avatar_and_header

  def self.from_omniauth(auth)
    user = where(email: auth.info.email).first

    return if user.blank?

    authorization = user.authorizations.find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    user.authorizations << authorization unless user.authorizations.exists?(provider: auth.provider, uid: auth.uid)
    user.save!
    user
  end

  def following?(target_user)
    followings.include?(target_user)
  end

  private

  def attach_default_avatar_and_header
    avatar.attach(io: File.open(Rails.root.join('app/assets/images/default_avatar.webp')),
                  filename: 'default_avatar.webp', content_type: 'image/webp')

    header_image.attach(io: File.open(Rails.root.join('app/assets/images/default_header.webp')),
                        filename: 'default_header.webp', content_type: 'image/webp')
  end
end
