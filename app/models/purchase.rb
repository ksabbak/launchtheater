class Purchase < ApplicationRecord
	belongs_to :showtime

	validates_presence_of :purchaser_name, :showtime 
	validates :email, presence: true, format: { with: /[\w.]+@[\w]+\.[a-zA-Z]+\z/ }

	validate :credit_card_number_valid
	validate :credit_card_expiration_date_valid



	def credit_card_number
		@credit_card_number
	end	

	def credit_card_number=(cc_number)
		@credit_card_number = cc_number.to_s.split(' ').join.to_i
	end	

	def credit_card_expiration_date
		@credit_card_expiration_date
	end	

	def credit_card_expiration_date=(cc_date)
		@credit_card_expiration_date = cc_date
	end	

	private
	def credit_card_number_valid
		#presence
		if !(credit_card_number)
			errors.add(:credit_card_number, "must be entered" )
		#there aren't weird characters
		elsif credit_card_number.to_i != credit_card_number
			errors.add(:credit_card_number, "can only be numbers")
		#correct length
		elsif credit_card_number.to_s.length != 16
			errors.add(:credit_card_number, "is invalid length")
		end
	end

	def credit_card_expiration_date_valid
		current_year = DateTime.current.year
		current_month = DateTime.current.month

		card_month = credit_card_expiration_date.split("/")[0]
		card_year = credit_card_expiration_date.split("/")[1]

		#presence
		if !(credit_card_expiration_date)
			errors.add(:credit_card_expiration_date, "must be present")
		#format
		elsif !(credit_card_expiration_date =~ /\d\d\/20\d\d/)
			errors.add(:credit_card_expiration_date, "format is invalid")
		#legit month
		elsif card_month > 13 || card_month < 1
			errors.add(:credit_card_expiration_date, "has an invalid month")
		#expiration hasn't passed
		elsif (card_year == current_year && card_month < current_month) || (card_year < current_year)
			errors.add(:credit_card_expiration_date, "has passed")
		end
	end

end
