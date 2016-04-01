class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
#  devise :database_authenticatable, :rememberable #, :registerable,
#         :recoverable, :trackable, :validatable

    mount_uploader :avatar, AvatarUploader

    acts_as_followable
    acts_as_follower

    validates :fname, presence: true
    validates :lname, presence: true


    def full_name
        "#{fname} #{mname} #{lname}".strip # <#{email}>"
    end

    def self.authenticate_by_email email, password
        user = User.find_by_email(email) if email && email.length > 0
        (user && user.valid_password?(password)) ? user : nil
    end
#    def self.authenticate_by_session key, salt
#        serialize_from_session(key, salt)
#    end

end
