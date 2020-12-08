class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :team_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true

  before_save :set_first_admin

  private

  def set_first_admin
    self.is_admin = true if User.all.count.zero?
  end
end
