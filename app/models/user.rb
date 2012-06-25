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

	devise :rpx_connectable
	attr_accessible :user_name, :first_name, :last_name, :primary_instrument, :email, :password, :password_confirmation

	has_many :microposts, :dependent=> :destroy
	has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
	has_many :followers, :through => :reverse_relationships, :source => :follower
	has_many :followed_users, :through => :relationships, :source => :followed
	has_many :reverse_relationships, :foreign_key => "followed_id",
                                   	 :class_name =>  "Relationship",
                                     :dependent =>   :destroy
   
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

  def feed
    Micropost.from_users_followed_by(self)
  end

  	def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(:followed_id => other_user.id)
  end

   def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

	private
	def create_remember_token
		self.remember_token =  SecureRandom.hex 
	end
end
