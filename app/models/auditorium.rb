class Auditorium < ApplicationRecord
	has_many :showtimes
	has_many :attendees, through: :showtimes, source: :purchases
	has_many :movies, through: :showtimes

end
