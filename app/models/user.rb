class User < ActiveRecord::Base
  validates :username, :email, :password_digest, :sessions_token, presence: true

  before_validation :ensure_sessions_token

  def self.find_by_credentials(username, password)
    user = User.find_by(:username => username)
    if user
      if user.is_password?(password)
        return user

      end
    end
    nil
  end

  def ensure_sessions_token
    self.sessions_token ||= SecureRandom::urlsafe_base64

  end

  def reset_sessions_token!
    self.sessions_token = SecureRandom::urlsafe_base64
    self.save!
  end

  def password=(value)
    self.password_digest = BCrypt::Password.create(value)

  end

  def is_password?(password)
    pass = BCrypt::Password.new(self.password_digest)
    pass.is_password?(password)

  end


end
