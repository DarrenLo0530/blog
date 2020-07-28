class Author < ApplicationRecord
  authenticates_with_sorcery!
  validates_confirmation_of :password, message: "Should match confirmation", if: :password
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :username, :email, :crypted_password, presence: true
end
