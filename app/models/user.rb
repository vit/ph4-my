class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    validates :fname, presence: true
    validates :lname, presence: true


  def full_name
#    fname.to_s + ' ' + mname.to_s + ' ' + lname.to_s + ' ' + "<"+email+">"
#    "#{fname} #{mname} #{lname} <#{email}>"

    "#{fname} #{mname} #{lname}".strip # <#{email}>"
  end
end
