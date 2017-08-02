class Showtime < ApplicationRecord
	belongs_to :movie
	belongs_to :auditorium
	has_many :purchases

end
