require 'bcrypt'
require 'securerandom'

class User
  include DataMapper::Resource
  attr_accessor :password_confirmation
  attr_reader :password

  has n, :spaces
  property :id, Serial
  property :name, String
  property :email, String, required: true, unique: true
  property :password_digest, Text
  property :password_token, String, length: 60
  property :password_token_time, Time

  validates_confirmation_of :password
  validates_format_of :email, as: :email_address

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = first(email: email)
    user && BCrypt::Password.new(user.password_digest) == password ? user : nil
  end

  def generate_token
    self.password_token = SecureRandom.hex
    self.password_token_time = Time.now
    save
  end

  def self.find_by_valid_token(token)
    user = first(password_token: token)
    user if user && user.password_token_time + (60 * 60) > Time.now
  end

end
