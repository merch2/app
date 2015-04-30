class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :vkontakte]

  has_many :questions
  has_many :answers
  has_many :votes, dependent: :destroy
  has_many :comments
  has_many :authorizations

  def self.find_for_oauth(auth)
    autorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return autorization.user if autorization

    if auth.info[:email].blank?
      email = "#{(0...15).map { ('a'..'z').to_a[rand(26)] }.join}@mail.ru"
    else
      email = auth.info[:email]
    end
    user  = User.find_by_email(email)
    if user
      user.authorizations.create(provider: auth.provider, uid: auth.uid)
    else
      password = Devise.friendly_token[0, 8]
      user = User.create!(email: email, password: password, password_confirmation: password)
      user.authorizations.create(provider: auth.provider, uid: auth.uid)
    end
    user
  end

end
