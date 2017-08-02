class Showtime < ApplicationRecord
	belongs_to :movie
	belongs_to :auditorium
	has_many :purchases

	validates_presence_of :start_time, :end_time

	#TODO: Set validation for movie times to not overlap in an auditorium.

end
