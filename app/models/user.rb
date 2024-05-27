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

  has_many :active_relationships, class_name: 'Follow', foreign_key: 'following_user_id', dependent: :destroy,
                                  inverse_of: :following_user
  has_many :following_users, through: :active_relationships, source: :followed_user
  has_many :passive_relationships, class_name: 'Follow', foreign_key: 'followed_user_id', dependent: :destroy,
                                   inverse_of: :followed_user
  has_many :followed_users, through: :passive_relationships, source: :following_user

  has_many :tweets, dependent: :destroy

  has_one_attached :avatar

  before_create :set_default_name
  after_create :attach_default_avatar

  validates :tel, presence: true, length: { maximum: 20 }, numericality: { only_integer: true }
  validates :birthday, presence: true,
                       format: { with: /\A\d{4}-\d{1,2}-\d{1,2}\z/, message: 'は「YYYY-MM-DD」の形式で入力してください' }

  def self.from_omniauth(auth)
    user = where(email: auth.info.email).first

    return if user.blank?

    authorization = user.authorizations.find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    user.authorizations << authorization unless user.authorizations.exists?(provider: auth.provider, uid: auth.uid)
    user.save!
    user
  end

  private

  def set_default_name
    random_string = SecureRandom.alphanumeric(16)
    random_name = "@#{random_string}"
    self.account_name = random_name
    self.display_name = random_name
  end

  def attach_default_avatar
    return if avatar.attached?

    avatar.attach(io: File.open(Rails.root.join('app/assets/images/default_profile.png')),
                  filename: 'default_profile.png', content_type: 'image/png')
  end
end
