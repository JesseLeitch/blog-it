class User < ActiveRecord::Base
	has_many :articles
	has_many :comments

	has_secure_password

	validates :password, :length => {:minimum => 5}, if: -> (o) { o.password.present? || o.password_digest.nil? }

	validates_presence_of :email
	
	mount_uploader :image, AvatarUploader
end
