class ActiveRecord::Base

#	validates_uniqueness_of :sid

#	def to_param
#		self.sid
#	end

#	def self.find(input)
#		find_by_sid(input)
#	end

	before_create :set_sid

	private
	def set_sid
		self.sid = SecureRandom.base58
	end


end
