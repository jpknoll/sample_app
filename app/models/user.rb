# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#
class User < ActiveRecord::Base
	attr_accessible :user_name, :first_name, :last_name, :primary_instrument, :email, :password, :password_confirmation
	has_secure_password
	before_save :create_remember_token

	validates(:user_name, :presence => true, :length => {:maximum => 50})
	validates(:first_name, :presence => true, :length => {:maximum => 50})
	validates(:last_name, :presence => true, :length => {:maximum => 50})
	validates(:password, :length => { :minimum => 6 })
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates(:email, 
		:presence => true, 
		:format => { :with => VALID_EMAIL_REGEX },
		:uniqueness => { :case_sensitive => false })
	validates :password_confirmation, :presence => true

	private
	def create_remember_token
		self.remember_token =  SecureRandom.hex 
	end
end
